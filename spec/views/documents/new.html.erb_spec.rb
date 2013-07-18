require 'spec_helper'

describe "documents/new" do
  before(:each) do
    assign(:document, stub_model(Document,
      :filename => "MyString",
      :doc_name => "MyString",
      :original_filename => "MyString",
      :users => nil
    ).as_new_record)
  end

  it "renders new document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documents_path, :method => "post" do
      assert_select "input#document_filename", :name => "document[filename]"
      assert_select "input#document_doc_name", :name => "document[doc_name]"
      assert_select "input#document_original_filename", :name => "document[original_filename]"
      assert_select "input#document_users", :name => "document[users]"
    end
  end
end
