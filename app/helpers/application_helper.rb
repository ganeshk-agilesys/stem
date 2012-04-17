module ApplicationHelper
  require 'open-uri'
  require 'net/https'
  require 'json'
  SALARY_LEVEL_MIN = %w(10000_dollars 20000_dollars 30000_dollars 40000_dollars 50000_dollars 60000_dollars 70000_dollars 80000_dollars 90000_dollars)
  EDUCATION_LEVEL = %w(less_than_a_high_school_diploma high_school_diploma post_secondary_certificate some_college_courses associates_degree bachelors_degree post_baccalaureate_certificate masters_degree post_masters_certificate first_professional_degree doctoral_degree post_doctoral_training)
  EDUCATION_TYPES = %w(degree_program continuing_education_course online_education certification)
  SORT_OPTIONS = %w(national_salary best_match)
  INDUSTRIES_FOR_OPTIONS =  JSON.parse(open(URI.escape("http://23.21.178.16/api/v1/industries.json")).read).collect{|a| [a["name"],a["id"]]}
  DISTANCE = %w(25_miles 50_miles 75_miles 100_miles)
  DATE_CREATED = %w(since_yesterday last_3_days last_week last_15_days last_30_days last_60_days last_90_days)
  ESTIMATED_SEPARATION = %w(within_the_next_week within_the_next_month within_the_next_4_months within_the_next_6_months within_the_next_year)
  DEFAULT_PER_PAGE = 10
  JOB_FUNCTION = %w(accounting_finance_insurance administrative_clerical banking_real_estate_mortgage construction_skill_trades business_strategic_management creative_design customer_support_client_care editorial_writing education_training engineering food_services hospitality human_resources installation_maintenance_repair it research_and_development software_development legal logistics_transportation manufacturing_production_operations marketing medical_health project_program_management quality_assurance sales_retail_business_development retail_business_development security_protective_services).sort
  TRAVEL_TIME = %w(10_percent 25_percent 50_percent 75_percent 100_percent)
  JOB_TYPE = %w(full_time part_time internship contractor)
  CAREER_LEVEL = %w(entry_student entry_non_student experienced mid_level_manager manager executive senior_executive other)
  SALARY_OPTIONS = %w(per_year per_hour)
  JOB_SITE = %w(virtual_telecommute indoors_office_store_workplace outdoors)
  JOB_HOURS_TYPE = %w(standard_monday_through_friday variable_work_days_and_times_will_vary)
  SALARY_TYPE = %w(unpaid negotiable specified_amount)
  SEND_INVITATIONS = %w(automatically manually)
  REASONS_FOR_CLOSING = %w(i_hired_a_candidate_from_pipeline i_hired_a_candidate_from_another_job_board i_hired_a_candidate_from_another_source i_couldnt_find_any_candidates_for_this_job this_position_is_no_longer_required)
  SORT_OPTIONS = %w(best_match created_at)
  
  
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
