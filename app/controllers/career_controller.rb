class CareerController < ApplicationController
  def search
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read)    
  end
   
  def search_result
    query_string = api_safe_params("search",params[:search])
    #    raise "http://23.21.178.16/api/v1/careers/search.json?#{query_string}".inspect
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
    #    @occupations= JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/search.json?q=#{params[:search][:keyword]}")).read)
    @occupations= JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/search.json?#{query_string}")).read)
    #    @occupations= JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/careers/search.json?#{query_string}")).read)
  end

  def assessment_result
    params[:search] = {} if params[:search].blank?
    params[:search][:riasec] = @riasec 
    params[:search][:skills] = @skills 
    query_string = api_safe_params("search",params[:search])
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
    @assessment_result = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/careers/search.json?#{query_string}")).read)
    
    @occupations = []
    unless @assessment_result.blank?
      @assessment_result.each do |o|
        @occupations << JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/#{o["api_safe_onet_soc_code"]}.json")).read)
      end
    end
  end

end
