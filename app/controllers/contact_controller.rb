class ContactController < ApplicationController
  layout 'home'

  def index
    @feedback = Feedback.new
  end
end
