class IndustryController < ApplicationController
  def show
    response = open URI.escape("http://127.0.0.1:3000/api/v1/industries/#{params[:id]}.json")
    @industry = JSON.parse(response.read)
    @careers = @industry["related_careers"]
    @video = nil
    if @industry.has_key?("sub_industry_ids") && !@industry["sub_industry_ids"].nil?
      @industry_list = []
      @industry["sub_industry_ids"].each do |si|
        sub_response = JSON.parse(open(URI.escape("http://127.0.0.1:3000/api/v1/industries/#{si}.json")).read)
        @industry_list << {"sub_id" => sub_response["id"]}
        @industry_list << {"sub_name" => sub_response["name"]}
      end
    end
  end
end
