describe 'describe incident' do
  include_context 'default_client_context'

  subject do
    client.describe_incident(incident_id)
  end

  let(:incident_id) { 123 }

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :get, path: "/api/v1/incidents/#{incident_id}"
    ).to_return(
      status: 200
    )
  end

  it do
    subject
    expect(stub).to have_been_requested
  end
end
