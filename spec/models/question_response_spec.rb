# frozen_string_literal: true

require 'rails_helper'

describe QuestionResponse, type: :model do
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:question) }

  it { is_expected.to validate_presence_of(:body).with_message(/Please enter some text/) }

  describe '#create_slug' do
    let(:user) { User.create!(email: 'ex@mpl.com', password: 'password', name: 'TestName') }
    let(:question) { Question.create!(body: 'test') }

    it 'creates a slug before saving' do
      question_response = QuestionResponse.new(body: 'DummyBody', user: user, question: question)

      question_response.save!

      expect(question_response.slug).to_not be_nil
    end

    it 'does not change the slug when updated' do
      question_response = QuestionResponse.create!(body: 'DummyBody', user: user, question: question, slug: 'example-slug')

      question_response.update!(body: 'UpdatedBody')
      question_response.reload

      expect(question_response.slug).to eq 'example-slug'
    end
  end
end
