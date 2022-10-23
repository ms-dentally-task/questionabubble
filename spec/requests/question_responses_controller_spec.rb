# frozen_string_literal: true

require "rails_helper"

RSpec.describe 'QuestionsController', type: :request do
  describe '#show' do
    let(:question) { Question.create!(body: 'test') }
    let(:question_response) { QuestionResponse.create!(body: 'DummyBody', question: question) }
    let(:show_action) { get question_response_path(question_response) }

    it 'redirects to the question path' do
      show_action

      expect(response).to redirect_to(question_path(question))
    end
  end

  describe '#create' do
    let(:user) { User.create!(name: 'DummyName', password: 'password', email: 'test@example.com') }
    let(:question) { Question.create!(body: 'test') }
    let(:create_action) { post question_responses_path, params: { question_response: valid_params } }
    let(:valid_params) {
      {
        body: 'DummyBody',
        question_id: question.id
      }
    }

    context 'as a non-logged-in user' do
      it 'creates a new question reponse' do
        expect { create_action }.to change { QuestionResponse.count }.by(1)
      end

      it 'redirects to user registration' do
        create_action

        question_response = QuestionResponse.last

        expect(response).to redirect_to(new_user_registration_path(question_response: question_response.slug))
      end
    end

    context 'as a logged-in user' do
      before do
        sign_in user
      end

      it 'redirects to the question' do
        create_action

        question_response = QuestionResponse.last

        expect(response).to redirect_to(question_path(question_response.question))
      end
    end
  end
end
