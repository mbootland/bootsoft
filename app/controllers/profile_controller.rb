class ProfileController < ApplicationController
  def index
    render(json: "Hello Julia") && return
  end
end