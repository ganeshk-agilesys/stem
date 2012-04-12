module ApplicationHelper
  SALARY_LEVEL_MIN = %w(10000_dollars 20000_dollars 30000_dollars 40000_dollars 50000_dollars 60000_dollars 70000_dollars 80000_dollars 90000_dollars)
  EDUCATION_LEVEL = %w(less_than_a_high_school_diploma high_school_diploma post_secondary_certificate some_college_courses associates_degree bachelors_degree post_baccalaureate_certificate masters_degree post_masters_certificate first_professional_degree doctoral_degree post_doctoral_training)
  EDUCATION_TYPES = %w(degree_program continuing_education_course online_education certification)
  SORT_OPTIONS = %w(national_salary best_match)
  INDUSTRIES_FOR_OPTIONS =  JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
  
    def translate_options(option_list, options = {})
    if option_list
      if option_list.select { |item| item.is_a?(Array) }.size > 0
        translate_grouped_options(option_list, options)
      else
        option_list = option_list.collect { |option| [I18n.t(option), option] } #there were performace issues with collect!

        if options[:include_blank].kind_of?(String) or options[:include_blank].kind_of?(Symbol)
          option_list.insert(0, [I18n.t(options[:include_blank]), ""])
        elsif options[:include_blank]
          option_list.insert(0, [I18n.t(:select_one), ""])
        end

        option_list
      end
    else
      []
    end
  end

  def translate_grouped_options(option_list, options={}, translate_options=true)
    # include_blank functionality has not been needed here yet.

    option_list.collect do |category|   # this iterative craziness is to adhere to the
      # specific format of grouped_options_for_select -TWB
      [ I18n.t(category[0]), category[1].collect do |item|
          if item.is_a?(String) and translate_options
            [ I18n.t(item), item ]
          else
            item
          end
        end ]
    end
  end
end
