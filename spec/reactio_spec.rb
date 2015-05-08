describe 'use Reactio as module' do
  before do
    ENV['REACTIO_API_KEY'] = 'THE_API_KEY'
    ENV['REACTIO_ORGANIZATION'] = 'my-organization'
  end

  let(:included_class) do
    Class.new.instance_eval { include Reactio }
  end

  let(:obj) do
    included_class.new
  end

  it { expect(obj.reactio).to respond_to(:create_incident) }
  it { expect(obj.reactio).to respond_to(:describe_incident) }
  it { expect(obj.reactio).to respond_to(:list_incidents) }
  it { expect(obj.reactio).to respond_to(:notify_incident) }
end
