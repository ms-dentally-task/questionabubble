class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if params[:question]
        Question.find_by(slug: params[:question])&.update!(user: resource)
      end
    end
  end

  def after_sign_up_path_for(resource)
    if params[:question].present?
      question_path(params[:question])
    else
      root_path
    end
  end
end
