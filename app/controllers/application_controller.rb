class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_necessary_files
  
  private
  def add_necessary_files
    require 'open-uri'
    require 'net/https'
    require 'json'
#    puts "Included all necessary files for Assessment"
  end
end
