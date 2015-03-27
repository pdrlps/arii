class InstallController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def local
  end

  def server
  end
end
