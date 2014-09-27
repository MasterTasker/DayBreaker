require 'rails_helper'

RSpec.describe User, :type => :model do

  before do @user = User.new(name: "Drew Erny", email: "drewerny@gmail.com",
                            password: "testpass", password_confirmation: "testpass")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  context "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  context "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  context "when email is not unique" do
    before do
      same_email = @user.dup
      same_email.save
    end

    it { should_not be_valid }
  end

  context "when password is not present" do
    before do
      @user.password = " "
      @user.password_confirmation = " "
    end
    
    it { should_not be_valid }
  end

  context "when the passwords do not match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  context "with a password less than six characters" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end

  describe "is being authenticated" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    context "with a valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    context "without a valid password" do
      let(:user_with_invalid_pass) { found_user.authenticate("invalid_pass") }

      it { should_not eq user_with_invalid_pass }
      specify { expect(user_with_invalid_pass).to be false }
    end
  end
end
