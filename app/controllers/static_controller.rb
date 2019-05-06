class StaticController < ApplicationController
  before_action :check_login

  def dummy
  end
end