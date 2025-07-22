# Testing Documentation

This Rails application has a comprehensive testing suite using RSpec, FactoryBot, and other testing gems.

## Testing Stack

- **RSpec Rails** (3.9): Testing framework for Rails applications
- **FactoryBot Rails** (4.11): Fixtures replacement for creating test data
- **Faker** (1.9): Library for generating fake data
- **Shoulda Matchers** (3.1): Matchers for common Rails functionality
- **Database Cleaner** (1.7): Ensures clean database state between tests

## Directory Structure

```
spec/
├── rails_helper.rb          # Main Rails testing configuration
├── spec_helper.rb           # RSpec configuration
├── models/                  # Model tests
│   ├── user_spec.rb
│   ├── charity_spec.rb
│   ├── transaction_spec.rb
│   └── support_spec.rb
├── controllers/             # Controller tests
│   ├── users_controller_spec.rb
│   └── charities_controller_spec.rb
├── requests/               # Integration/API tests
│   └── api_spec.rb
├── factories/              # FactoryBot factories
│   ├── users.rb
│   ├── charities.rb
│   ├── transactions.rb
│   └── supports.rb
└── support/                # Test configuration
    ├── factory_bot.rb
    └── database_cleaner.rb
```

## Running Tests

### All Tests
```bash
bundle exec rspec
```

### Specific Test Files
```bash
# Run model tests
bundle exec rspec spec/models/

# Run controller tests  
bundle exec rspec spec/controllers/

# Run a specific test file
bundle exec rspec spec/models/user_spec.rb
```

### Specific Tests
```bash
# Run tests matching a description
bundle exec rspec --grep "associations"

# Run tests with focus
bundle exec rspec --tag focus
```

## Test Categories

### Model Tests (`spec/models/`)
Tests for ActiveRecord models including:
- Associations (has_many, belongs_to, etc.)
- Validations
- Instance methods
- Class methods
- Scopes

### Controller Tests (`spec/controllers/`)
Tests for Rails controllers including:
- HTTP responses
- JSON output
- Parameter handling
- Authentication/authorization

### Request Tests (`spec/requests/`)
Integration tests that test the full stack:
- API endpoints
- JSON responses
- HTTP status codes
- End-to-end functionality

## Factories

FactoryBot factories are defined in `spec/factories/` and provide clean, maintainable test data:

```ruby
# Create a user
user = create(:user)

# Build a user (not saved)
user = build(:user)

# Create multiple users
users = create_list(:user, 3)
```

## Configuration

### Database Cleaner
Configured to use transactions for faster tests, with truncation for JavaScript tests.

### Shoulda Matchers
Provides convenient matchers for testing associations and validations:

```ruby
it { should have_many(:transactions) }
it { should belong_to(:user) }
it { should validate_presence_of(:email) }
```

## Test Data

- Use FactoryBot for creating test objects
- Use Faker for generating realistic fake data
- Keep test data isolated and deterministic

## Best Practices

1. **Use descriptive test names** that explain what is being tested
2. **Follow the AAA pattern**: Arrange, Act, Assert
3. **Use contexts** to group related tests
4. **Test edge cases** and error conditions
5. **Keep tests fast** by using build instead of create when persistence isn't needed
6. **Use shared examples** for common behavior testing

## Example Test Structure

```ruby
RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:transactions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  describe '#full_name' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }
    
    it 'returns the full name' do
      expect(user.full_name).to eq('John Doe')
    end
  end
end
```

## Continuous Integration

Tests should be run in CI/CD pipelines to ensure code quality. The test suite is designed to be:
- Fast and reliable
- Independent (tests don't depend on each other)
- Deterministic (same input always produces same output)

## Debugging Tests

### Useful RSpec options:
```bash
# Run with documentation format
bundle exec rspec --format documentation

# Stop on first failure
bundle exec rspec --fail-fast

# Run only failed tests from last run
bundle exec rspec --only-failures

# Profile slow tests
bundle exec rspec --profile
```