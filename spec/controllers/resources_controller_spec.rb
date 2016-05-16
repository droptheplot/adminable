describe Adminable::ResourcesController do
  class Broken
  end

  class Adminable::BrokenController < Adminable::ResourcesController
  end

  context Adminable::BrokenController do
    let(:broken_controller) { Adminable::BrokenController.new }

    describe '#fields' do
      it 'raises error if not overridden' do
        expect{
          broken_controller.instance_eval { fields }
        }.to raise_error(Adminable::FieldsNotDefined)
      end
    end
  end
end
