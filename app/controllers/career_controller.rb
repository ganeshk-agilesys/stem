class CareerController < ApplicationController
  def search
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read)    
  end
   
  def search_result
    params[:search] = {} if params[:search].blank?
    params[:search][:sort] ||= 'national_salary'
    query_string = api_safe_params("search",params[:search])
    params[:q].present? ? q = "q=#{params[:q]}"+"&" : q = ''
    @industries = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
    @search_result= JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/search.json?#{q}#{query_string}")).read)
    
    @occupations = []
    unless @search_result.blank?
      @search_result.each do |o|
        @occupations << JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/#{o["api_safe_onet_soc_code"]}.json")).read)
      end
    end
  end

  def assessment_result
    params[:search] = {} if params[:search].blank?
    riasec = (params[:riasec] || params[:search][:riasec])
    skills = (params[:skills] ||  params[:search][:skills])
    params[:search][:riasec] = riasec
    params[:search][:skills] = skills
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
