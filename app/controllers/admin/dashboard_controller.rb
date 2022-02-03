class Admin::DashboardController < ApplicationController
  def show
  end
  http_basic_authenticate_with username: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
end
