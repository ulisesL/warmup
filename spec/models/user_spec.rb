require 'spec_helper'

describe User do

  before do
    @user = User.new(username: "Example", password: "user123")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:password) }

  it { should be_valid }

  describe "when username is already taken" do
    
    before do
      user_with_same_username = @user.dup
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 129 }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.password = "a" * 129 }
    it { should_not be_valid }
  end

end