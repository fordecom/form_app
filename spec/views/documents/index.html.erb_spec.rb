require 'spec_helper'

describe "documents/index" do
  before(:each) do
    assign(:documents, [
      stub_model(Document,
        :filename => "Filename",
        :doc_name => "Doc Name",
        :original_filename => "Original Filename",
        :users => nil
      ),
      stub_model(Document,
        :filename => "Filename",
        :doc_name => "Doc Name",
        :original_filename => "Original Filename",
        :users => nil
      )
    ])
  end

  it "renders a list of documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
    assert_select "tr>td", :text => "Doc Name".to_s, :count => 2
    assert_select "tr>td", :text => "Original Filename".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
