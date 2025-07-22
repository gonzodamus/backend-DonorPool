require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:cards) }
    it { should have_many(:addresses) }
    it { should have_many(:transactions) }
    it { should have_many(:charities).through(:transactions) }
    it { should have_many(:supports) }
    it { should have_many(:supported_charities).through(:supports).source(:charity) }
    it { should have_one(:management) }
    it { should have_one(:managed_charity).through(:management).source(:charity) }
  end

  describe 'password authentication' do
    it { should have_secure_password }
  end

  describe 'factory' do
    it 'creates a valid user' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe 'user creation' do
    let(:user) { create(:user) }

    it 'can be created with valid attributes' do
      expect(user).to be_persisted
      expect(user.email).to be_present
      expect(user.first_name).to be_present
      expect(user.last_name).to be_present
    end

    it 'can authenticate with correct password' do
      expect(user.authenticate('password123')).to eq(user)
    end

    it 'returns false with incorrect password' do
      expect(user.authenticate('wrong_password')).to be_falsey
    end
  end

  describe 'associations functionality' do
    let(:user) { create(:user) }
    let(:charity) { create(:charity) }

    it 'can have transactions' do
      transaction = create(:transaction, user: user, charity: charity)
      expect(user.transactions).to include(transaction)
      expect(user.charities).to include(charity)
    end

    it 'can support charities' do
      support = create(:support, user: user, charity: charity)
      expect(user.supports).to include(support)
      expect(user.supported_charities).to include(charity)
    end
  end
end