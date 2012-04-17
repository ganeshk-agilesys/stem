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
  
  def api_safe_params name,hash_param
    unless hash_param.blank?
      outs = ''
      hash_param.each_pair { |key,value| outs += 
          name+'['+key.to_s+']='+value.to_s+'&'} 
      outs.chomp('&')
    else
      ''
    end
  end
end
