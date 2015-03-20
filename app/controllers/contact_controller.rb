class ContactController < ApplicationController
  layout 'home'

  def index
    @feedback = Feedback.new
    @alpha = Alpha.new
  end
end
