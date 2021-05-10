# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: user_info_request_sent_alerts
#
#  id                    :integer          not null, primary key
#  user_id               :integer          not null
#  info_request_id       :integer          not null
#  alert_type            :string           not null
#  info_request_event_id :integer
#  created_at            :datetime
#  updated_at            :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe UserInfoRequestSentAlert do
  describe 'scopes' do
    let!(:recent) do
      FactoryBot.create(:user_info_request_sent_alert, created_at: 1.year.ago)
    end

    let!(:old) do
      FactoryBot.create(:user_info_request_sent_alert, created_at: 366.days.ago)
    end

    it 'can scope to recent sent alerts' do
      expect(described_class.recent).to include(recent)
      expect(described_class.recent).to_not include(old)
    end
  end

  it 'should allow an alert type of "survey_1"' do
    alert = UserInfoRequestSentAlert.new(alert_type: 'survey_1')
    expect(alert).to be_valid
  end
end
