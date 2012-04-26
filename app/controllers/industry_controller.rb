class IndustryController < ApplicationController
  def show
    @industry = parse_json("http://usmilitarypipeline.com/api/v1/industries/#{params[:id]}.json")
    @careers = @industry["related_careers"]
    @video = nil
    if @industry.has_key?("sub_industry_ids") && !@industry["sub_industry_ids"].nil?
      @industry_list = []
      @industry["sub_industry_ids"].each do |si|
        sub_response = parse_json("http://usmilitarypipeline.com/api/v1/industries/#{si}.json")
        @industry_list << {"sub_id" => sub_response["id"],"sub_name" => sub_response["name"]}
      end
    end
  end
end
