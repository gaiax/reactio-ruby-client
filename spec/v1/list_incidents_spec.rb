describe 'list incidents' do
  include_context 'default_service_context'

  subject do
    service.list_incidents(options)
  end

  before { stub }

  let(:incident_list) { fixture('incident_list') }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :get, path: '/api/v1/incidents',
      body: expected_options.to_json
    ).to_return(
      status: 200,
      body: incident_list.to_json
    )
  end

  context 'without options option' do
    subject { service.list_incidents }
    let(:expected_options) { {} }
    it { is_expected.to eq(incident_list) }
  end

  context 'with from option' do
    let(:options) { { from: time } }
    let(:expected_options) { { from: time.to_i } }
    let(:time) { Time.parse('2015-01-23 12:34:56') }
    it { is_expected.to eq(incident_list) }
  end

  context 'with to option' do
    let(:options) { { to: time } }
    let(:expected_options) { { to: time.to_i } }
    let(:time) { Time.parse('2015-01-23 12:34:56') }
    it { is_expected.to eq(incident_list) }
  end

  context 'with status option' do
    let(:options) { { status: status } }

    context 'given open as status' do
      let(:status) { 'open' }
      let(:expected_options) { { status: 'open' } }
      it { is_expected.to eq(incident_list) }
    end

    context 'given pend as status' do
      let(:status) { 'pend' }
      let(:expected_options) { { status: 'pend' } }
      it { is_expected.to eq(incident_list) }
    end

    context 'given close as status' do
      let(:status) { 'close' }
      let(:expected_options) { { status: 'close' } }
      it { is_expected.to eq(incident_list) }
    end
  end

  context 'with page option' do
    let(:options) { { page: 1 } }
    let(:expected_options) { { page: 1 } }
    it { is_expected.to eq(incident_list) }
  end

  context 'with per_page option' do
    let(:options) { { per_page: 100 } }
    let(:expected_options) { { per_page: 100 } }
    it { is_expected.to eq(incident_list) }
  end
end
