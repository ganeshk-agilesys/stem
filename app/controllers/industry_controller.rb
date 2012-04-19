class IndustryController < ApplicationController
  def show
    response = open URI.escape("http://usmilitarypipeline.com/api/v1/industries/#{params[:id]}.json")
    @industry = JSON.parse(response.read)
    @careers = @industry["related_careers"]
    @video = nil
    if @industry.has_key?("sub_industry_ids") && !@industry["sub_industry_ids"].nil?
      @industry_list = []
      @industry["sub_industry_ids"].each do |si|
        sub_response = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/industries/#{si}.json")).read)
        @industry_list << {"sub_id" => sub_response["id"],"sub_name" => sub_response["name"]}
      end
    end
    @links = @industry["related_careers"] if @industry.has_key?("related_careers")   
  end
end
