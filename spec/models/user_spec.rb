# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(name:, email:, password_digest:) }

  let(:email) { 'example@test.com' }
  let(:password_digest) { 'qwerty' }
  let(:name) { 'user' }

  it 'is valid' do
    expect(user).to be_valid
  end
end
