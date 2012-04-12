class AssessmentController < ApplicationController
  def index
    #    begin
    response = open URI.escape("http://23.21.178.16/api/v1/assessment.json")
    #    raise JSON.parse(response.read).inspect
    @questions = JSON.parse(response.read)
    @assessment = ""
    #    rescue
    #      flash.now[:notice] = "Hey! Something went wrong."
    #    end
  end
  
  def assessment_result
    @assessment = ""
    (1..14).each do |num|
      @assessment << (params["skill_question_#{num}".to_sym] || "0")
    end
    
    if @assessment[0..5] =~ /^[1-5]{6}$/ and @assessment[6..13] =~ /^[1-5]{8}$/
      @assessment_result = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/careers/#{@assessment[0..5]}/#{@assessment[6..13]}.json")).read)  
      @occupations = []
      @assessment_result.each do |o|
        @occupations << JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/careers/#{o["api_safe_onet_soc_code"]}.json")).read)
      end
    else
      @questions = JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/assessment.json")).read)
      flash.now[:notice] = "Please answer all questions"
      render :action => 'index'
    end
  end
  
end
