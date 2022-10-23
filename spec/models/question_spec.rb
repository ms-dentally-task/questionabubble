## frozen_string_literal: true

require 'rails_helper'

describe Question, type: :model do
  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to have_many(:question_responses) }

  it { is_expected.to validate_presence_of(:body).with_message(/Please enter some text/) }

  describe '#create_slug' do
    it 'creates a slug before saving' do
      question = Question.new(body: 'DummyBody')

      question.save!

      expect(question.slug).to_not be_nil
    end

    it 'does not change the slug when updated' do
      question = Question.create!(body: 'DummyBody', slug: 'example-slug')

      question.update!(body: 'UpdatedBody')

      expect(question.slug).to eq 'example-slug'
    end
  end
end
