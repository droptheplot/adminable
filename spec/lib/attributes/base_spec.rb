describe Cms::Attributes::Base do
  describe '#initialize' do
    it 'raise error' do
      expect { Cms::Attributes::Base.new('user') }.to raise_error
    end
  end
end
