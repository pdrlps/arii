class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    unless user_signed_in?
      redirect_to root_url
      return
    end

    if current_user.status == 110
      @clients = Client.all
    else
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status != 110
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # GET /clients/new
  def new
    begin
      if current_user.status == 110
        @client = Client.new
      else
        redirect_to root_url, :notice => 'Unauthorized Access.'
      end
    rescue Exception => e
      redirect_to root_url
    end
  end

  # GET /clients/1/edit
  def edit
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status != 110
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:name, :email, :phone, :message, :payload, :origin)
  end
end
