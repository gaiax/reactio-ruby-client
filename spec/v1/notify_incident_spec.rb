describe 'execute notification' do
  include_context 'default_client_context'

  subject do
    client.notify_incident(incident_id, options)
  end

  let(:incident_id) { 123 }

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :post, path: '/api/v1/notifications',
      body: { incident_id: incident_id }.merge(expected_options)
    ).to_return(
      status: 201,
      body: notification.to_json
    )
  end

  let(:notification) { fixture('notification') }

  context 'without options' do
    subject { client.notify_incident(incident_id) }
    let(:expected_options) { {} }
    it { is_expected.to eq(notification) }
  end

  context 'with notification text option' do
    let(:options) { { text: text } }
    let(:expected_options) { { text: text } }
    let(:text) { '至急対応をお願いします。' }
    it { is_expected.to eq(notification) }
  end

  context 'with notification call option' do
    let(:options) { { call: call } }
    let(:expected_options) { { call: call } }

    context 'given true as call' do
      let(:call) { true }
      it { is_expected.to eq(notification) }
    end

    context 'given false as call' do
      let(:call) { false }
      it { is_expected.to eq(notification) }
    end
  end
end
