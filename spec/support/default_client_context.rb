shared_context 'default_client_context' do
  let(:client) { Reactio::Client.new(api_key: api_key, organization: organization) }
  let(:api_key) { 'api_key_for_organization' }
  let(:organization) { 'your-organization' }
end
