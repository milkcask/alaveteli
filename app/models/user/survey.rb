module User::Survey
  def survey
    return @survey if @survey
    @survey = MySociety::Survey.new(AlaveteliConfiguration.site_name, email)
  end

  def can_send_survey?
    active? && !survey.already_done?
  end
end
