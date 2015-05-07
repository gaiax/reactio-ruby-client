describe 'execute notification' do
  include_context 'default_client_context'

  subject do
    client.notify_incident(incident_id, options)
  end

  before { stub }

  let(:incident_id) { 123 }

  context 'without options' do
    subject { client.notify_incident(incident_id) }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :post, path: '/api/v1/notifications',
        body: { incident_id: incident_id }
      ).to_return(
        status: 201
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with notification text option' do
    let(:options) { { text: text } }
    let(:text) { '至急対応をお願いします。' }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :post, path: '/api/v1/notifications',
        body: {
          incident_id: incident_id,
          text: text
        }
      ).to_return(
        status: 201
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with notification call option' do
    let(:options) { { call: call } }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :post, path: '/api/v1/notifications',
        body: {
          incident_id: incident_id,
          call: call
        }
      ).to_return(
        status: 201
      )
    end

    context 'given true as call' do
      let(:call) { true }

      it do
        subject
        expect(stub).to have_been_requested
      end
    end

    context 'given false as call' do
      let(:call) { false }

      it do
        subject
        expect(stub).to have_been_requested
      end
    end
  end
end
