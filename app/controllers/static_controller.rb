class StaticController < ApplicationController
  
  def privacy
    generic
  end

  def about
    generic
  end
 
  def support
    generic
  end
  
  def term
    generic
  end
  
  def resources
    @industries = JSON.parse(open(URI.escape("http://usmilitarypipeline.com/api/v1/industries.json")).read)
    generic
  end

  def videos
    generic
  end
  
  def industries
    generic
  end
  
  def generic
    respond_to do |format|
      format.html
    end
  end
end
