# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  # Association tests
  describe 'associations' do
    it { should have_many(:user_roles) }
    it { should have_many(:users).through(:user_roles) }
  end

  # Validation tests (if applicable)
  describe 'validations' do
    it 'is valid with valid attributes' do
      role = Role.new(name: 'Admin')

      expect(role).to be_valid
    end

    it 'is not valid without a name' do
      role = Role.new

      expect(role).not_to be_valid
      expect(role.errors[:name]).to include("can't be blank")
    end
  end
end
