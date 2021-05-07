require 'spec_helper'

RSpec.describe Survey do
  describe '.enabled?' do
    subject { described_class.enabled? }

    context 'when ENABLE_SURVEY_EMAILS and SURVEY_URL are configured' do
      before do
        allow(AlaveteliConfiguration).to receive(:enable_survey_emails).
          and_return(true)
        allow(AlaveteliConfiguration).to receive(:survey_url).
          and_return('https://example.com')
      end

      it { is_expected.to eq true }
    end

    context 'when ENABLE_SURVEY_EMAILS are configured' do
      before do
        allow(AlaveteliConfiguration).to receive(:enable_survey_emails).
          and_return(true)
      end

      it { is_expected.to eq false }
    end

    context 'when SURVEY_URL are configured' do
      before do
        allow(AlaveteliConfiguration).to receive(:survey_url).
          and_return('https://example.com')
      end

      it { is_expected.to eq false }
    end

    context 'when niether ENABLE_SURVEY_EMAILS and SURVEY_URL are configured' do
      it { is_expected.to eq false }
    end
  end
end
