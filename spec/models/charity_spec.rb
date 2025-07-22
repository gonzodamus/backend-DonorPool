require 'rails_helper'

RSpec.describe Charity, type: :model do
  describe 'associations' do
    it { should have_many(:transactions) }
    it { should have_many(:users).through(:transactions) }
    it { should have_many(:supports) }
    it { should have_many(:supporters).through(:supports).source(:user) }
    it { should have_many(:updates) }
    it { should have_one(:management) }
    it { should have_one(:manager).through(:management).source(:user) }
  end

  describe 'factory' do
    it 'creates a valid charity' do
      charity = build(:charity)
      expect(charity).to be_valid
    end
  end

  describe 'charity creation' do
    let(:charity) { create(:charity) }

    it 'can be created with valid attributes' do
      expect(charity).to be_persisted
      expect(charity.name).to be_present
      expect(charity.description).to be_present
      expect(charity.cause).to be_present
    end
  end

  describe 'associations functionality' do
    let(:charity) { create(:charity) }
    let(:user) { create(:user) }

    it 'can have transactions from users' do
      transaction = create(:transaction, user: user, charity: charity)
      expect(charity.transactions).to include(transaction)
      expect(charity.users).to include(user)
    end

    it 'can have supporters' do
      support = create(:support, user: user, charity: charity)
      expect(charity.supports).to include(support)
      expect(charity.supporters).to include(user)
    end
  end
end