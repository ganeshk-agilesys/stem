class JobController < ApplicationController
  
  def search
    if params[:search].present?
      #    params[:search] = {} if params[:search].blank?
      params[:search][:client_ip] = request.remote_ip
      params[:search][:client_useragent] = request.env['HTTP_USER_AGENT']
      @page = params[:page].blank? ? 1 : params[:page].to_i
      @per_page = params[:per_page].blank? ? ApplicationHelper::DEFAULT_PER_PAGE : params[:per_page].to_i
      query_string = api_safe_params("search",params[:search])
      @job_posts = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/jobs/search.json?#{query_string}")).read)
    end
  end
  
  def show
    @job_post = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/jobs/#{params[:id]}.json")).read)
  end
  
end
