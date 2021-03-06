class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @feedback = Feedback.new
    @client = Client.new
    unless user_signed_in?
      redirect_to root_url
      return
    end
    if current_user.status == 110
      @feedbacks = Feedback.order(created_at: :desc)
      respond_with(@feedbacks)
    else
      redirect_to root_url, :notice => 'Unauthorized Access.'
    end
  end

  def show
    @feedback = Feedback.new
    @client = Client.new
    @f = Feedback.find_by_id(params[:id])
    respond_with(@f)
  end

  def new
    @feedback = Feedback.new
    @client = Client.new
    @feedback = Feedback.new
    respond_with(@feedback)
  end

  def edit
  end

  def create
    @feedback = Feedback.new(feedback_params)
    flash[:notice] = 'Feedback was successfully created.' if @feedback.save
    Services::Slog.info({:message => "New feedback saved", :module => "FeedbacksController", :task => "create_feedback", :extra => {:feedback => @feedback}})
    respond_with(@feedback)
  end

  def update
    flash[:notice] = 'Feedback was successfully updated.' if @feedback.update(feedback_params)
    respond_with(@feedback)
  end

  def destroy
    @feedback.destroy
    respond_with(@feedback)
  end

  private
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :subject, :message, :origin, :payload, :details)
  end
end
