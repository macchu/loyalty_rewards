class HeroPagesController < ApplicationController
  layout 'hero_page'  
  def index 
    render :index
  end
end