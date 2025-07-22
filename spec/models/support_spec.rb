require 'rails_helper'

RSpec.describe Support, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:charity) }
  end

  describe 'factory' do
    it 'creates a valid support' do
      support = build(:support)
      expect(support).to be_valid
    end
  end

  describe 'support creation' do
    let(:user) { create(:user) }
    let(:charity) { create(:charity) }
    let(:support) { create(:support, user: user, charity: charity) }

    it 'can be created with valid attributes' do
      expect(support).to be_persisted
      expect(support.user).to eq(user)
      expect(support.charity).to eq(charity)
    end

    it 'requires a user' do
      support = build(:support, user: nil)
      expect(support).not_to be_valid
    end

    it 'requires a charity' do
      support = build(:support, charity: nil)
      expect(support).not_to be_valid
    end
  end
end