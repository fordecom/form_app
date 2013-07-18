require 'spec_helper'

describe "documents/edit" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :filename => "MyString",
      :doc_name => "MyString",
      :original_filename => "MyString",
      :users => nil
    ))
  end

  it "renders the edit document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documents_path(@document), :method => "post" do
      assert_select "input#document_filename", :name => "document[filename]"
      assert_select "input#document_doc_name", :name => "document[doc_name]"
      assert_select "input#document_original_filename", :name => "document[original_filename]"
      assert_select "input#document_users", :name => "document[users]"
    end
  end
end
