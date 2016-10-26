require 'rails_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit '/signin' }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
end

describe "User pages" do

  subject { page }

  describe "signup page" do

    before { visit '/signup' }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

    describe "with valid information" do
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }        
      end
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    # Replace with code to make a user variable
    let(:user){visit '/signup'}

    it { should have_content(User.name) }
    it { should have_title(user.name) }
  end
end