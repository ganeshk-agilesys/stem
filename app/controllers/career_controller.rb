class CareerController < ApplicationController
  def search
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read)    
  end
   
  def search_result
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
    @occupations= JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/search.json?q=#{params[:search][:keyword]}")).read)
  end

end
