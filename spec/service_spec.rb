module Reactio
  describe Service do
    describe '.new' do
      let(:api_key) { 'THE_API_KEY' }
      let(:organization) { 'my-organization' }

      context 'given valid options' do
        subject do
          described_class
            .new(
              api_key: api_key,
              organization: organization
            )
        end
        it { expect(subject.api_key).to eq(api_key) }
        it { expect(subject.organization).to eq(organization) }
      end

      context 'given only api_key option' do
        subject do
          described_class.new(api_key: api_key)
        end
        it { expect { subject }.to raise_error(ArgumentError, 'organization is required') }
      end

      context 'given only organization option' do
        subject do
          described_class.new(organization: organization)
        end
        it { expect { subject }.to raise_error(ArgumentError, 'api_key is required') }
      end

      context 'given no options' do
        subject do
          described_class.new
        end
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
