describe 'create incident' do
  include_context 'default_client_context'

  subject do
    client.create_incident(name, options)
  end

  let(:name) { 'サイト閲覧不可' }

  before { stub }

  let(:stub) do
    stub_api_request(
      organization, api_key,
      method: :post, path: '/api/v1/incidents',
      body: { name: name }.merge(expected_options)
    ).to_return(
      status: 201,
      body: incident.to_json
    )
  end

  let(:incident) { fixture('created_incident') }

  context 'without options' do
    subject { client.create_incident(name) }
    let(:expected_options) { {} }
    it { is_expected.to eq(incident) }
  end

  context 'with status option' do
    let(:options) { { status: status } }
    let(:expected_options) { { status: status.to_s } }

    context 'given :open as status' do
      let(:status) { :open }
      it { is_expected.to eq(incident) }
    end

    context 'given :pend as status' do
      let(:status) { :pend }
      it { is_expected.to eq(incident) }
    end

    context 'given :close as status' do
      let(:status) { :close }
      it { is_expected.to eq(incident) }
    end
  end

  context 'with detection option' do
    let(:options) { { detection: detection } }

    context 'given :msp as detection' do
      let(:detection) { :msp }
      let(:expected_options) { { detection: 'msp' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :system as detection' do
      let(:detection) { :system }
      let(:expected_options) { { detection: 'system' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :client as detection' do
      let(:detection) { :client }
      let(:expected_options) { { detection: 'client' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :internal as detection' do
      let(:detection) { :internal }
      let(:expected_options) { { detection: 'internal' } }
      it { is_expected.to eq(incident) }
    end

    context 'given nil as detection' do
      let(:detection) { nil }
      let(:expected_options) { { detection: 'null' } }
      it { is_expected.to eq(incident) }
    end
  end

  context 'with cause option' do
    let(:options) { { cause: cause } }

    context 'given :over_capacity as cause' do
      let(:cause) { :over_capacity }
      let(:expected_options) { { cause: 'over-capacity' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :bug as cause' do
      let(:cause) { :bug }
      let(:expected_options) { { cause: 'bug' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :operation_error as cause' do
      let(:cause) { :operation_error }
      let(:expected_options) { { cause: 'operation-error' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :external_factor as cause' do
      let(:cause) { :external_factor }
      let(:expected_options) { { cause: 'external-factor' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :degradation as cause' do
      let(:cause) { :degradation }
      let(:expected_options) { { cause: 'degradation' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :unknown as cause' do
      let(:cause) { :unknown }
      let(:expected_options) { { cause: 'unknown' } }
      it { is_expected.to eq(incident) }
    end

    context 'given nil as cause' do
      let(:cause) { nil }
      let(:expected_options) { { cause: 'null' } }
      it { is_expected.to eq(incident) }
    end
  end

  context 'with cause_supplement option' do
    let(:options) { { cause_supplement: cause_supplement } }
    let(:expected_options) { { cause_supplement: cause_supplement } }
    let(:cause_supplement) { 'Webサーバがアクセス過多でダウン' }
    it { is_expected.to eq(incident) }
  end

  context 'with point option' do
    let(:options) { { point: point } }

    context 'given :network as point' do
      let(:point) { :network }
      let(:expected_options) { { point: 'network' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :shared_hardware as point' do
      let(:point) { :shared_hardware }
      let(:expected_options) { { point: 'shared-hardware' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :hardware as point' do
      let(:point) { :hardware }
      let(:expected_options) { { point: 'hardware' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :os as point' do
      let(:point) { :os }
      let(:expected_options) { { point: 'os' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :middleware as point' do
      let(:point) { :middleware }
      let(:expected_options) { { point: 'middleware' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :application as point' do
      let(:point) { :application }
      let(:expected_options) { { point: 'application' } }
      it { is_expected.to eq(incident) }
    end

    context 'given nil as point' do
      let(:point) { nil }
      let(:expected_options) { { point: 'null' } }
      it { is_expected.to eq(incident) }
    end
  end

  context 'with scale option' do
    let(:options) { { scale: scale } }

    context 'given :cross as scale' do
      let(:scale) { :cross }
      let(:expected_options) { { scale: 'cross' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :whole as scale' do
      let(:scale) { :whole }
      let(:expected_options) { { scale: 'whole' } }
      it { is_expected.to eq(incident) }
    end

    context 'given :point as scale' do
      let(:scale) { :point }
      let(:expected_options) { { scale: 'point' } }
      it { is_expected.to eq(incident) }
    end

    context 'given nil as scale' do
      let(:scale) { nil }
      let(:expected_options) { { scale: 'null' } }
      it { is_expected.to eq(incident) }
    end
  end

  context 'with pend_text option' do
    let(:options) { { pend_text: pend_text } }
    let(:expected_options) { { pend_text: pend_text } }
    let(:pend_text) { 'Webサーバの再起動を行う' }
    it { is_expected.to eq(incident) }
  end

  context 'with close_text option' do
    let(:options) { { close_text: close_text } }
    let(:expected_options) { { close_text: close_text } }
    let(:close_text) { 'Webサーバのスケールアウトを行う' }
    it { is_expected.to eq(incident) }
  end

  context 'with topics option' do
    let(:options) { { topics: topics } }
    let(:expected_options) { { topics: topics } }
    let(:topics) { %w(原因調査 復旧作業) }
    it { is_expected.to eq(incident) }
  end

  context 'with notification_text option' do
    let(:options) { { notification_text: notification_text } }
    let(:expected_options) { { notification_text: notification_text } }
    let(:notification_text) { '至急対応をお願いします。' }
    it { is_expected.to eq(incident) }
  end

  context 'with notification_call option' do
    let(:options) { { notification_call: notification_call } }
    let(:expected_options) { { notification_call: notification_call } }

    context 'given true as notification_call' do
      let(:notification_call) { true }
      it { is_expected.to eq(incident) }
    end

    context 'given false as notification_call' do
      let(:notification_call) { false }
      it { is_expected.to eq(incident) }
    end
  end
end
