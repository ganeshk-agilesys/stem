module IndustryHelper
  def industry_image(image_url,size_type='normal')
    if image_url.present?
       splitted_url = image_url.split(/(_normal-\w*)/) 
       image_tag(splitted_url[0]+"_#{size_type}"+splitted_url[2])
    end
  end
end
