module Survey
  def self.enabled?
    AlaveteliConfiguration.enable_survey_emails &&
      AlaveteliConfiguration.survey_url.present?
  end
end
