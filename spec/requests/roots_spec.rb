require 'spec_helper'

describe "Root" do

  describe "Login page" do

    it "should have the h1 'Form App'" do
      visit '/root/login'
      page.should have_selector('h1', :text => 'Login')
    end

    it "should have the title 'Login'" do
      visit '/root/login'
      page.should have_selector('title', :text => "BCC Form App | Login")
    end
  end

  describe "Logout page" do

    it "should have the h1 'Form App'" do
      visit '/root/logout'
      page.should have_selector('h1', :text => 'Logout')
    end

    it "should have the title 'Logout'" do
      visit '/root/logout'
      page.should have_selector('title', :text => "BCC Form App | Logout")
    end
  end

  describe "Index Page" do 
   
    it "should have the h1 'Index'" do
      visit '/root/index'
      page.should have_selector('h1', :text => 'Index')
    end

  it "should have the title 'Index'" do
      visit '/root/index'
      page.should have_selector('title', :text => "BCC Form App | Index")
    end
  end
end
