class DashboardController < ApplicationController

	layout "dashboard"

	before_action :authenticate_user!
	
	def home;end
end
