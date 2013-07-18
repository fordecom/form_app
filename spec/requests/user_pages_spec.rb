require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        puts "Filling in info"
        fill_in "user_name",         with: "Example"
        fill_in "user_surname",      with: "User"
        fill_in "user_pps",          with: "1785238F"
        fill_in "user_email",        with: "user@example.com"
        fill_in "user_password",     with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end      

      describe "after saving the user" do
        before { click_button submit; puts "clicking button" }
        let(:user) do
          puts User.all.inspect
          u = User.find_by_email('user@example.com') 
          puts u.inspect
          u
        end
        it { should have_selector('title', text: "BCC Form App | " + user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end     
        it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end 
    end  
  end
end
