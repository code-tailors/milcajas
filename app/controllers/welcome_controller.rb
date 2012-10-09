class WelcomeController < ApplicationController

  def index
    flash[:notice]="hola chabon como va"
  end
end