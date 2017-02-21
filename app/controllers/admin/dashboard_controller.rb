class Admin::DashboardController < Admin::AdminController
  def show
    @impressions = Impression.recent
  end
end