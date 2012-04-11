class AssessmentController < ApplicationController
  def index
    #    begin
    response = open URI.escape("http://127.0.0.1:3000/api/v1/assessment.json")
    #    raise JSON.parse(response.read).inspect
    @questions = JSON.parse(response.read)
    @riasec = ""
    @skills = ""
    #    rescue
    #      flash.now[:notice] = "Hey! Something went wrong."
    #    end
  end
  
  def assessment_result
    @riasec = ""
    @skills = ""
    (1..6).each do |num|
      @riasec << (params["skill_question_#{num}".to_sym] || "0")
    end
    (7..14).each do |num|
      @skills << (params["skill_question_#{num}".to_sym] || "0")
    end
    if @riasec =~ /^[1-5]{6}$/ and @skills =~ /^[1-5]{8}$/
      @response = JSON.parse(open(URI.escape("http://127.0.0.1:3000/api/v1/careers/#{@riasec}/#{@skills}.json")).read)
      
    else
      flash[:error] = "Please answer all questions"
      render :action => 'index'
    end
  end
  
end
