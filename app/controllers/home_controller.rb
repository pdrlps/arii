class HomeController < ApplicationController
  layout "home"

  def index
    if user_signed_in? then
      redirect_to :controller => "dashboard", :action => "index"
    end

    @alpha = Alpha.new
  end
end
