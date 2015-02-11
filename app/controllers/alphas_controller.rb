class AlphasController < ApplicationController
  before_action :set_alpha, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.status == 110
      @alphas = Alpha.all
      respond_with(@alphas)
    else
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  def show
    respond_with(@alpha)
  end

  def new
    @alpha = Alpha.new
    respond_with(@alpha)
  end

  def edit
  end

  def create
    @alpha = Alpha.new(alpha_params)
    flash[:notice] = 'Alpha was successfully created.' if @alpha.save
    respond_with(@alpha)
  end

  def update
    flash[:notice] = 'Alpha was successfully updated.' if @alpha.update(alpha_params)
    respond_with(@alpha)
  end

  def destroy
    @alpha.destroy
    respond_with(@alpha)
  end

  private
    def set_alpha
      @alpha = Alpha.find(params[:id])
    end

    def alpha_params
      params.require(:alpha).permit(:name, :email, :job)
    end
end
