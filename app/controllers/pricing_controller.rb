class PricingController < ApplicationController
  layout 'home'

  def index
    @client = Client.new
  end
end
