class HowController < ApplicationController
  layout "home"

  def index
    @alpha = Alpha.new
  end
end
