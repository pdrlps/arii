require 'securerandom'

class AgentsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @agents = current_user.agents
    @feedback = Feedback.new
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    begin
      @agent = current_user.agents.find(params[:id])

    rescue Exception => e
      flash[:notice] = "You are not authorized to access that Input."
      Services::Slog.exception e
      redirect_to :root
    end
  end

  # GET /agents/new
  def new
    @schedules = {}

    timings = JSON.parse(ENV["APP_SCHEDULE"])
    timings.each do |timing|
      timing.each do |schedule, full|
        @schedules[schedule] = full
      end
    end
    @agent = Agent.new

    respond_to do |format|
      format.html {render action: "new"}
      format.js { render layout: "application" }
    end
  end

  # GET /agents/1/edit
  def edit
    @schedules = {}
    @schedules['local'] = 'Local'
    @schedules['push'] = 'Push'
    timings = JSON.parse(ENV["APP_SCHEDULE"])
    timings.each do |timing|
      timing.each do |schedule, full|
        @schedules[schedule] = full
      end
    end
  end

  # POST /agents
  # POST /agents.json
  def create
    @help = Services::Helper.new
    @agent = Agent.new agent_params
    @agent.last_check_at = @help.datetime
    @agent.status = 100
    @agent.events_count = 0
    @agent.identifier ="in_#{SecureRandom.hex(32)}"

    respond_to do |format|
      if @agent.save
        current_user.agents.push(@agent)
        current_user.save
        format.json { render json: @agent, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|

      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: 'Input was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    current_user.agents.delete(@agent)

    # Remove from integrations
    @agent.integrations.each do |integration|
      integration.agents.delete(@agent)

      # check if integrations has templates, remove if all empty
      if integration.templates.empty?
        current_user.integrations.delete(integration)
        integration.destroy
      end
    end

    @agent.destroy
    respond_to do |format|
      format.html { redirect_to inputs_url }
      format.json { head :no_content }
    end
  end

  def import
    @file = File.read("data/inputs/#{params[:identifier]}.js")
    @agent = Agent.create! JSON.parse(@file)

    response = { :status => 200, :message => "[ARiiP]: input #{params[:identifier]} imported", :id => @agent[:id] }
    respond_to do |format|
      format.json { render :json => response}
      format.xml { render :xml => response}
    end
  end

  ##
  # => Start agent monitoring process (on demand).
  #
  def execute
    begin
      @agent = current_user.agents.find(params[:id])
      Thread.new {
        begin
          response = @agent.execute
        rescue Exception => e
          Services::Slog.exception e
        end
      }

      respond_to do |format|
        format.html { redirect_to @agent, notice: 'Input execution started.' }
      end
    rescue Exception => e
      Services::Slog.exception e
    end

  end

  ##
  # => Add existing sample agents to user.
  #
  def add
    @object = JSON.parse(File.read("data/inputs/#{params[:identifier]}.js"))
    @agent = Agent.create! @object
    @agent.events_count = 0
    @agent.last_check_at = Time.now
    @agent.identifier ="in_#{SecureRandom.hex(32)}"
    current_user.agents.push @agent
    if @agent.save then
      respond_to do |format|
        format.html { redirect_to @agent }
      end
    end
  end

  def partials
    render :partial => "publisher#{params[:identifier]}"
  end

  def get
    begin
      @agent = Agent.find(params[:id])
      respond_to do |format|
        format.json { render :json => @agent}
        format.xml { render :xml => @agent}
      end
    rescue Exception => e
      Services::Slog.exception e
    end
  end

  ##
  # Disable input (will not execute!). Status = 400
  def disable
    begin
      @input = current_user.agents.find(params[:id])
      @input.status = 400

      @input.save
      respond_to do |format|
        format.json {render json: @input}
      end
    rescue Exception => e
      Services::Slog.exception e
      format.json {render json: @input}
    end
  end

  ##
  # Enable input (will execute!). Status = 100
  def enable
    begin
      @input = current_user.agents.find(params[:id])
      @input.status = 100

      @input.save
      respond_to do |format|
        format.json {render json: @input}
      end
    rescue Exception => e
      Services::Slog.exception e
      format.json {render json: @input}
    end
  end

  ##
  # Download agent configuration (if local)
  def download
    begin
      key = current_user.api_keys.first.access_token
    rescue Exception => e
      key = ApiKey.create!
      current_user.api_keys.push key
      key.save
      current_user.save
    end

    begin
      @input = current_user.agents.find(params[:id])#, :select => 'identifier, publisher, payload')

      if @input.schedule == 'local'


        @inputs = Array.new
        input = Hash.new
        input[:identifier] = @input[:identifier]
        input[:publisher] = @input[:publisher]
        input[:payload] = @input[:payload]
        @inputs.push input
        @client = Hash.new
        @server = Hash.new
        @server[:host] = ENV["APP_HOST"]
        @server[:name] = ENV["APP_TITLE"]
        @server[:access_token] = key
        @client[:server] = @server
        @client[:agents] = @inputs
        respond_to do |format|
          format.json  {
            #render :json => @client
            send_data JSON.pretty_generate(@client), :filename => "#{@input[:identifier]}.js", :type => 'application/json', :disposition => 'attachment'
          }
          format.js  {
            #render :json => @client
            send_data JSON.pretty_generate(@client), :filename => "#{@input[:identifier]}.js", :type => 'application/json', :disposition => 'attachment'
          }
        end
      end
    rescue Exception => e
      Services::Slog.exception e
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_agent
    begin
      @agent = Agent.find(params[:id])
    rescue Exception => e
      Services::Slog.exception e
      flash[:notice] = "Sorry, <i class=\"icon-ariip\"></i> couldn't find the input identified by <em>#{params[:id]}</em>."
      redirect_to :controller => "agents", :action => "index"
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def agent_params
    a = params[:agent].clone
    #a[:selectors] = JSON.parse(a[:selectors])
    a.permit(:publisher, :payload, :identifier, :title, :help, :schedule, :action, :uri, :cache, :headers, :delimiter, :checked ,:server, :host, :port, :database, :username, :password, :query, :selectors, :sheet)
  end

end
