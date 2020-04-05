class InstallController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def local
  end

  def server
  end
end
