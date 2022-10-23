# frozen_string_literal: true

RSpec.describe 'RegistrationsController', type: :request do
  describe '#create' do
    let(:valid_params) do
      {
        user: {
          name: 'ExampleName',
          email: 'test123@example.com',
          password: 'password'
        }
    }
    end
    let(:create_action) { post user_registration_path, params: valid_params }

    it 'creates a user record' do
      expect { create_action }.to change { User.count }.by(1)
    end

    it 'redirects to root path' do
      create_action

      expect(response).to redirect_to(root_path)
    end

    context 'with a question slug' do
      let(:question) { Question.create(body: 'DummyBody') }
      let(:valid_params) { super().merge(question: question.slug) }

      it 'associates the user with the question' do
        create_action

        question.reload

        expect(question.user).to_not be_nil
      end

      it 'redirects to the question' do
        create_action

        expect(response).to redirect_to(question_path(question))
      end
    end
  end
end
