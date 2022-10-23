class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      add_user_to_question(resource) if params[:question]
      add_user_to_question_response(resource) if params[:question_response]
    end
  end

  def after_sign_up_path_for(resource)
    if params[:question].present?
      question_path(params[:question])
    elsif params[:question_response].present?
      question_response_path(params[:question_response])
    else
      root_path
    end
  end

  def add_user_to_question(resource)
    Question.find_by(slug: params[:question])&.update!(user: resource)
  end

  def add_user_to_question_response(resource)
    QuestionResponse.find_by(slug: params[:question_response])&.update!(user: resource)
  end
end
