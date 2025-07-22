require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:charity) }
  end

  describe 'factory' do
    it 'creates a valid transaction' do
      transaction = build(:transaction)
      expect(transaction).to be_valid
    end
  end

  describe 'transaction creation' do
    let(:user) { create(:user) }
    let(:charity) { create(:charity) }
    let(:transaction) { create(:transaction, user: user, charity: charity) }

    it 'can be created with valid attributes' do
      expect(transaction).to be_persisted
      expect(transaction.user).to eq(user)
      expect(transaction.charity).to eq(charity)
      expect(transaction.amount).to be_present
    end

    it 'requires a user' do
      transaction = build(:transaction, user: nil)
      expect(transaction).not_to be_valid
    end

    it 'requires a charity' do
      transaction = build(:transaction, charity: nil)
      expect(transaction).not_to be_valid
    end
  end
end