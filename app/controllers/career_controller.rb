class CareerController < ApplicationController
 def search
    response = open URI.escape("http://23.21.178.16/api/v1/industries.json")
    @industries = JSON.parse(response.read)
  end
   
  def search_result
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
  end

end
