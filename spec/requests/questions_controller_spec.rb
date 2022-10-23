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
    context 'as a non-logged-in user' do
      context 'with valid params' do
        let(:valid_params) { { body: 'DummyBody' } }
        let(:create_action) { post questions_path, params: { question: valid_params } }

        it 'creates a new question' do
          expect { create_action }.to change { Question.count }.by(1)
        end

        it 'returns a created response' do
          create_action

          expect(response).to have_http_status(:created)
        end
      end
    end
  end
end
