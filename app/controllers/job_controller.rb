class JobController < ApplicationController
  
  def search
    if params[:search].present?
      #    params[:search] = {} if params[:search].blank?
      params[:search][:client_ip] = request.remote_ip
      params[:search][:client_useragent] = request.env['HTTP_USER_AGENT']
      @page = params[:page].blank? ? 1 : params[:page].to_i
      @per_page = params[:per_page].blank? ? ApplicationHelper::DEFAULT_PER_PAGE : params[:per_page].to_i
      query_string = api_safe_params("search",params[:search])
#      @job_posts = JobPost.search_jobs(@search, :page => @page, :per_page => @per_page)
      @job_posts = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/jobs/search.json?#{query_string}")).read)
 
#      all_job_titles = @search.mocs_found.collect(&:job_titles).flatten.slice(0,10).sort
#      @job_titles_part1 = all_job_titles.slice(0, 5)
#      @job_titles_part2 = all_job_titles.slice(5, 5)
    end
  end
  
end
