require 'httparty'
require 'open-uri'
require 'json'

class ConnectPipeline
  include HTTParty
  #  base_uri 'http://10.0.15.44:8088'
  base_uri 'http://localhost:3000'
  format :json
  
  
  # retrive records based on moc ids
  def self.get_assessment()
    #    categories = ["GetRankListMatchsByMocId","GetSkillListMatchsByMocId","GetEmployerSpecificJobMatchsByMocId"]
    #    response = get("/MatchService.svc//GetDetailsByMoc/?MocId=11B,88M&FunctionName=GetRankListMatchsByMocId,GetSkillListMatchsByMocId,GetEmployerSpecificJobMatchsByMocId")
    response = get("/api/v1/assessment.json")
    if response.success?
      raise response.inspect
      #      categories.each do |category|
      #        puts category.inspect
      #        puts "================="
      #        parsed_response = JSON.parse(response.flatten.compact[1])[category] 
      #        parsed_response.each do |res|
      #          res.keys.each do |key|
      #            puts res[key]
      #          end
      #        end
      #      end
    else
      # this just raises the net/http response that was raised
      raise response.response    
    end
  end
   
end