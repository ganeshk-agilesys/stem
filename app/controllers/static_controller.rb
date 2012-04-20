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
    generic
  end
  
  def generic
    respond_to do |format|
      format.html
    end
  end
end
