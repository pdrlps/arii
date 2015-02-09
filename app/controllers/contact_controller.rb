class ContactController < ApplicationController

  def index
    @feedback = Feedback.new
    @alpha = Alpha.new
  end
end