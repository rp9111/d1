class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :authorize_admin!
end
