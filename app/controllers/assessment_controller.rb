class AssessmentController < ApplicationController
  def index
    response = open URI.escape("http://usmilitarypipeline.com/api/v1/assessment.json")
    @questions = JSON.parse(response.read)
    @assessment = ""
  end
  
  def assessment
    @assessment = ""
    (1..14).each do |num|
      @assessment << (params["skill_question_#{num}".to_sym] || "0")
    end
    @riasec = @assessment[0..5]
    @skills = @assessment[6..13]
    if @riasec =~ /^[1-5]{6}$/ and @skills =~ /^[1-5]{8}$/
      redirect_to career_assessment_result_path(:riasec => @riasec, :skills => @skills)
    else
      @questions = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/assessment.json")).read)
      flash.now[:notice] = "Please answer all questions"
      render :action => 'index'
    end
  end

end
