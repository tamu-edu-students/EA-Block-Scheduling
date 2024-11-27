# /spec/models/user_role_spec.rb

require 'rails_helper'

RSpec.describe UserRole, type: :model do
  # Association tests
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end

  # Validation tests
  describe 'validations' do
    let(:user) { create(:user) } # Create a user using the factory
    let(:role) { create(:role, name: 'Admin') } # Assuming a Role factory exists

    it 'is valid with valid attributes' do
      user_role = UserRole.new(user: user, role: role)

      expect(user_role).to be_valid
    end

    it 'is not valid without a user' do
      user_role = UserRole.new(role: role)

      expect(user_role).not_to be_valid
      expect(user_role.errors[:user]).to include("must exist")
    end

    it 'is not valid without a role' do
      user_role = UserRole.new(user: user)

      expect(user_role).not_to be_valid
      expect(user_role.errors[:role]).to include("must exist")
    end
  end
end
