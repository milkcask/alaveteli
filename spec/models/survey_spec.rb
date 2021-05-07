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

  describe '.url' do
    subject { described_class.url(info_request) }

    let(:info_request) { FactoryBot.build(:info_request) }
    let(:public_body) { info_request.public_body }

    before do
      allow(AlaveteliConfiguration).to receive(:survey_url).
        and_return('https://example.com')
    end

    context 'when public body has 10 different requesters' do
      before do
        10.times { FactoryBot.create(:info_request, public_body: public_body) }
      end

      it 'adds authority_id GET param to base survey url' do
        is_expected.to eq(
          "https://example.com?authority_id=#{public_body.to_param}"
        )
      end
    end

    context 'when public body has less than 10 different requesters' do
      it 'returns base survey url' do
        is_expected.to eq 'https://example.com'
      end
    end
  end
end
