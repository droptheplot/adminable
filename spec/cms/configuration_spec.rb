describe Cms::Configuration do
  before do
    allow(Cms::Configuration).to receive(:resources_paths).and_return(
      %w(/app/controllers/cms/tests_controller.rb /app/controllers/cms/test/tests_controller.rb)
    )
  end

  describe '#resources' do
    it 'return correct resources' do
      expect(Cms::Configuration.resources).to eq([
        { name: 'tests', path: 'tests' },
        { name: 'test_tests', path: 'test/tests' }
      ])
    end
  end
end
