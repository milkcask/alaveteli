module Survey
  def self.enabled?
    AlaveteliConfiguration.enable_survey_emails &&
      AlaveteliConfiguration.survey_url.present?
  end

  def self.url(info_request)
    public_body = info_request.public_body

    users = User.distinct.joins(:info_requests).
      where(info_requests: { public_body: public_body })

    return AlaveteliConfiguration.survey_url if users.count < 10

    Addressable::URI.parse(AlaveteliConfiguration.survey_url).tap do |url|
      url.query_values = (url.query_values || {}).merge(
        authority_id: public_body.to_param
      )
    end.to_s
  end
end
