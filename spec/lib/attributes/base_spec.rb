describe Adminable::Attributes::Base do
  describe '#initialize' do
    it 'raise error' do
      expect { Adminable::Attributes::Base.new('user') }.to raise_error
    end
  end
end
