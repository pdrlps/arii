class ContactController < ApplicationController
  layout "documentation"

  def index
    @feedback = Feedback.new
    @alpha = Alpha.new
  end
end