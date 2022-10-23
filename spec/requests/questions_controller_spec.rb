# frozen_string_literal: true

require "rails_helper"

RSpec.describe 'QuestionsController', type: :request do
  describe '#new' do
   let(:show_action) { get new_question_path }

    context 'as a non-logged-in user' do
      it 'returns a success response' do
        show_action

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#show' do
   let(:question) { Question.create!(body: 'example') }
   let(:show_action) { get question_path(question) }

    context 'as a non-logged-in user' do
      it 'returns a success response' do
        show_action

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#create' do
    let(:create_action) { post questions_path, params: { question: valid_params } }
    let(:valid_params) { { body: 'DummyBody' } }

    context 'as a non-logged-in user' do
      it 'creates a new question' do
        expect { create_action }.to change { Question.count }.by(1)
      end

      it 'redirects to user registration' do
        create_action

        question = Question.last

        expect(response).to redirect_to(new_user_registration_path(question: question.slug))
      end
    end

    context 'as a logged-in user' do
      let(:user) { User.create!(name: 'DummyName', password: 'password', email: 'test@example.com') }

      before do
        sign_in user
      end

      it 'redirects to the question' do
          create_action

          question = Question.last

          expect(response).to redirect_to(question_path(question))
      end
    end
  end
end
