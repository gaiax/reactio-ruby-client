describe 'handle error' do
  include_context 'default_service_context'

  subject do
    service.notify_incident(incident_id, foo: 'bar')
  end

  before { stub }

  let(:incident_id) { 456 }
  let(:options) { { foo: 'bar' } }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :post, path: '/api/v1/notifications',
      body: { incident_id: incident_id }.merge(options).to_json
    ).to_return(
      status: 400,
      body: error_response.to_json
    )
  end

  let(:error_response) do
    {
      errors: [
        { field: "notification_text", code: "missing_field" }
      ],
      type: "validation_error",
      message: "validation error"
    }
  end

  it { expect { subject }.to raise_error(Reactio::APIError, error_response.inspect) }
end
