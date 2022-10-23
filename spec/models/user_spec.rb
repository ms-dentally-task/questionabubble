## frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end