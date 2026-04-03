require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(email_address: "you@example.com", password: "s3cr3t", password_confirmation: "s3cr3t")

    expect(user).to be_valid
  end
end
