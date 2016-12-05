require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")}
  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should be_valid}

  describe "when name is not present" do
    before { @user.name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before { @user.email = ""}
    it {should_not be_valid}
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51}
    it {should_not be_valid}
  end

  describe "when email address is already token" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase # for testing the case insensitive property
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: "", password_confirmation: "")
    end

    it {should_not be_valid}
  end

  describe "when password does not match the confirmation_password" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "mismatchpassword")
    end
    it {should_not be_valid}
  end

  describe "when password is too short" do
    before do
      @user.password = @user.password_confirmation = "a" * 5
    end
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
    before { @user.save}
    let(:found_user) { User.find_by(email: @user.email)}

    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_with_invalid_password){ found_user.authenticate("invalid")}

      it {should_not eq user_with_invalid_password}
      specify { expect(user_with_invalid_password).to be_falsey}
    end
  end
end
