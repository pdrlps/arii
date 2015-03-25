class BetasController < ApplicationController
  layout 'home'
  before_action :set_beta, only: [:show, :edit, :update, :destroy]

  # GET /betas
  # GET /betas.json
  def index
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status == 110
      @betas = Betas.all
    else
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # GET /betas/1
  # GET /betas/1.json
  def show
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status != 110
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # GET /betas/new
  def new
    unless user_signed_in?
      redirect_to root_url
      return
    end
    @beta = Betas.new
  end

  # GET /betas/1/edit
  def edit
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status != 110
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  # POST /betas
  # POST /betas.json
  def create
    @beta = Betas.new(beta_params)

    respond_to do |format|
      if @beta.save
        format.html { redirect_to @beta, notice: 'Betas was successfully created.' }
        format.json { render :show, status: :created, location: @beta }
      else
        format.html { render :new }
        format.json { render json: @beta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /betas/1
  # PATCH/PUT /betas/1.json
  def update
    respond_to do |format|
      if @beta.update(beta_params)
        format.html { redirect_to @beta, notice: 'Betas was successfully updated.' }
        format.json { render :show, status: :ok, location: @beta }
      else
        format.html { render :edit }
        format.json { render json: @beta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /betas/1
  # DELETE /betas/1.json
  def destroy
    @beta.destroy
    respond_to do |format|
      format.html { redirect_to betas_index_url, notice: 'Betas was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_beta
    @beta = Betas.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def beta_params
    params.require(:betas).permit(:origin, :name, :email, :job, :payload, :what)
  end
end
