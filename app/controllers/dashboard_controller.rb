class DashboardController < ApplicationController
  def index
    @integrations = current_user.integrations
    @inputs = current_user.agents
    @outputs = current_user.templates
    @events = Event.by_user_limit(current_user)
  end

  def show
  end

  def update
  end
end
