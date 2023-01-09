class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
end
