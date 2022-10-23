## frozen_string_literal: true

require 'rails_helper'

describe Question, type: :model do
  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_presence_of(:body).with_message(/Please enter some text/) }
end
