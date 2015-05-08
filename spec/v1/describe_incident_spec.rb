describe 'describe incident' do
  include_context 'default_service_context'

  subject do
    service.describe_incident(123)
  end

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :get, path: "/api/v1/incidents/123"
    ).to_return(
      status: 200,
      body: incident.to_json
    )
  end

  let(:incident) { fixture('incident') }

  it { is_expected.to eq(incident) }
end
