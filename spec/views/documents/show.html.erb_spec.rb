require 'spec_helper'

describe "documents/show" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :filename => "Filename",
      :doc_name => "Doc Name",
      :original_filename => "Original Filename",
      :users => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filename/)
    rendered.should match(/Doc Name/)
    rendered.should match(/Original Filename/)
    rendered.should match(//)
  end
end
