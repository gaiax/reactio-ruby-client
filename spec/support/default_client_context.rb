shared_context 'default_service_context' do
  let(:service) { Reactio::Service.new(api_key: api_key, organization: organization) }
  let(:api_key) { 'api_key_for_organization' }
  let(:organization) { 'your-organization' }
end
