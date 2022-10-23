# frozen_string_literal: true

RSpec.describe 'VotesController', type: :request do
  describe '#create' do
    let(:user) { User.create!(name: 'DummyName', password: 'password', email: 'test@example.com') }
    let(:question) { Question.create!(body: 'test') }
    let(:question_response) { QuestionResponse.create!(body: 'test', question: question) }
    let(:create_action) { post votes_path(format: :turbo_stream), params: { vote: valid_params } }
    let(:valid_params) {
      {
        voteable_id: question_response.id,
        voteable_type: question_response.class.name
      }
    }

    context 'as a non-logged-in user' do
      it 'redirects an unauthorised response' do
        create_action

        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not create a vote' do
        expect { create_action }.not_to change { Vote.count }
      end
    end

    context 'as a logged-in user' do
      before do
        sign_in user
      end

      it 'returns a created http status' do
        create_action

        expect(response).to have_http_status(:created)
      end

      it 'returns relevant content in the turbo response' do
        create_action

        expect(response.body).to include("Bubbled up!")
      end
    end
  end

  describe '#destroy' do
    let(:user) { User.create!(name: 'DummyName', password: 'password', email: 'test@example.com') }
    let(:question) { Question.create!(body: 'test') }
    let(:voteable) { QuestionResponse.create!(body: 'test', question: question) }
    let!(:vote) { Vote.create!(user: user, voteable: voteable) }

    let(:delete_action) { delete vote_path(vote, format: :turbo_stream) }

    context 'as a non-logged-in user' do
      it 'redirects an unauthorised response' do
        delete_action

        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not delete a vote' do
        expect { delete_action }.not_to change { Vote.count }
      end
    end

    context 'as a logged-in user' do
      before do
        sign_in user
      end

      it 'returns an ok http status' do
        delete_action

        expect(response).to have_http_status(:ok)
      end

      it 'does deletes a vote' do
        expect { delete_action }.to change { Vote.count }.by(-1)
      end
    end
  end
end
