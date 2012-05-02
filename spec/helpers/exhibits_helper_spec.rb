require_relative '../spec_helper_lite'
stub_class 'Exhibit'
require_relative '../../app/helpers/exhibits_helper'

describe ExhibitsHelper do
  subject { Object.new.extend(ExhibitsHelper) }
  let(:context) { stub! }

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    mock(::Exhibit).exhibit(model, context)
    subject.exhibit(model, context)
  end
end
