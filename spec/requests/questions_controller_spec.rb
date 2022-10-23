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
end
