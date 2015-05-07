describe 'describe incident' do
  include_context 'default_client_context'

  subject do
    client.describe_incident(123)
  end

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :get, path: "/api/v1/incidents/123"
    ).to_return(
      status: 200
    )
  end

  it do
    subject
    expect(stub).to have_been_requested
  end
end
