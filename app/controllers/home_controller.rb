class HomeController < ApplicationController
  def index
  	if user_signed_in? then
  		redirect_to :controller => "integrations", :action => "index"
  	end

    @alpha = Alpha.new
  end
end