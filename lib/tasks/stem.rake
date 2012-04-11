namespace :connect_pipeline do
  desc "Connect Pipeline"
  task :assessment => :environment do
    puts "Inside Assessment"
    require 'open-uri'
    require 'net/https'
    require 'addressable/uri'
    require 'json'
    puts "Included all necessary files for Assessment"
    response = open URI.escape("http://127.0.0.1:3000/api/v1/assessment.json")
    puts "Included all necessary files for Assessment"
    raise JSON.parse(response.read).inspect
    if response.success?
      raise response.inspect
    else
      # this just raises the net/http response that was raised
      raise response.response    
    end
    
  end
end