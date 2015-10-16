# encoding:utf-8

describe 'create message' do
  include_context 'default_service_context'

  subject do
    service.create_message(incident_id, options)
  end

  let(:incident_id) { 123 }

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :post, path: '/api/v1/messages',
      body: { incident_id: incident_id }.merge(message: message_content).to_json
    ).to_return(
      status: 201,
      body: message.to_json
    )
  end

  let(:message) { {} }

  context 'given message' do
    let(:options) { { message: message_content } }
    let(:message_content) { '<p>至急原因調査を実施！</p><a href="https://reactio.jp"><img src="https://reactio.jp/imgs/logo.png" /></a><br />' }
    it { is_expected.to eq(message) }
  end
end
