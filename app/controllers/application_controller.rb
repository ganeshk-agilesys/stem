class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_necessary_files
  rescue_from OpenURI::HTTPError, :with =>:show_error
  def show_error
    render :text => "<div class='wrapperbanr' style='text-align: center;width: 25em;padding: 0 4em;margin: 4em auto 0 auto;border: 1px solid #ccc;border-right-color: #999;border-bottom-color: #999;'><h3 style='color:red'>We're sorry, but unable to connect to the remote server right now.</h3><p>We've been notified about this issue and we'll take a look at it shortly.</p></div>", :layout => false
  end
  
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
