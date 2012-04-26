class CareerController < ApplicationController
  def search
    @industries = parse_json("http://usmilitarypipeline.com/api/v1/industries.json")    
  end
   
  def search_result
    params[:search] = {} if params[:search].blank?
    params[:search][:sort] ||= 'national_salary'
    query_string = api_safe_params("search",params[:search])
    params[:q].present? ? q = "q=#{params[:q]}"+"&" : q = ''
    @industries = parse_json("http://usmilitarypipeline.com/api/v1/industries.json").collect{|a| [a["name"],a["id"]]}
    @search_result= parse_json("http://usmilitarypipeline.com/api/v1/careers/search.json?#{q}#{query_string}")
    
    @occupations = []
    unless @search_result.blank?
      @search_result.each do |o|
        @occupations << parse_json("http://usmilitarypipeline.com/api/v1/careers/#{o["api_safe_onet_soc_code"]}.json")
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
    @industries = parse_json("http://usmilitarypipeline.com/api/v1/industries.json").collect{|a| [a["name"],a["id"]]}
    @assessment_result = parse_json("http://usmilitarypipeline.com/api/v1/careers/search.json?#{query_string}")
    
    @occupations = []
    unless @assessment_result.blank?
      @assessment_result.each do |o|
        @occupations << parse_json("http://usmilitarypipeline.com/api/v1/careers/#{o["api_safe_onet_soc_code"]}.json")
      end
    end
  end
  
  def show
    @occupation  = parse_json("http://usmilitarypipeline.com/api/v1/careers/#{params[:api_safe_onet_code]}.json")
  end

end
