require 'spec_helper'

describe "Root" do

  subject { page }

  describe "Login page" do
    before { visit root_path}

    it { should have_selector('h1', text: 'Login') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Login' }
  end

  describe "Logout page" do

    before { visit logout_path}

    it { should have_selector('h1', text: 'Logout') }
    it { should have_selector('title', text: full_title('Logout')) }
  end


  describe "Index Page" do 

    before { visit index_path}

    it { should have_selector('h1', text: 'Index') }
    it { should have_selector('title', text: full_title('Index')) }
  end

  describe "Contact page" do

    before { visit contact_path}

    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end
