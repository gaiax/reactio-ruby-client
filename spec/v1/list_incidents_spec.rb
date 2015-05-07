describe 'list incidents' do
  include_context 'default_client_context'

  subject do
    client.list_incidents(query)
  end

  before { stub }

  context 'without query option' do
    subject { client.list_incidents }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents'
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with from option' do
    let(:query) { { from: time } }
    let(:time) { Time.parse('2015-01-23 12:34:56') }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents',
        body: { from: time.to_i }
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with to option' do
    let(:query) { { to: time } }
    let(:time) { Time.parse('2015-01-23 12:34:56') }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents',
        body: { to: time.to_i }
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with status option' do
    let(:query) { { status: status } }
    let(:status) { :open }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents',
        body: { status: status.to_s }
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with page option' do
    let(:query) { { page: page } }
    let(:page) { 1 }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents',
        body: { page: page }
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end

  context 'with per_page option' do
    let(:query) { { per_page: per_page } }
    let(:per_page) { 100 }

    let(:stub) do
      stub_api_request(
        organization, api_key,
        method: :get, path: '/api/v1/incidents',
        body: { per_page: per_page }
      ).to_return(
        status: 200
      )
    end

    it do
      subject
      expect(stub).to have_been_requested
    end
  end
end
