describe 'describe incident' do
  subject do
    client.describe_incident(incident_id)
  end

  let(:client) { Reactio::Client.new(api_key: api_key, organization: organization) }
  let(:api_key) { 'api_key_for_organization' }
  let(:organization) { 'your-organization' }
  let(:incident_id) { 123 }

  before { stub }

  let(:stub) do
    stub_request(:get, "https://#{organization}.reactio.jp/api/v1/incidents/#{incident_id}")
      .with(:headers => {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'X-Api-Key' => api_key
      })
      .to_return(status: 200)
  end

  it do
    subject
    expect(stub).to have_been_requested
  end
end
