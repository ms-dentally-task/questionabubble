# frozen_string_literal: true

class QuestionResponsesController < ApplicationController
  def show
    @question_response = QuestionResponse.find_by!(slug: params[:id])

    redirect_to question_path(@question_response.question)
  end

  def create
    @question_response = QuestionResponse.new(question_response_params)
    @question_response.user = current_user

    if @question_response.save
      if @question_response.user
        redirect_to question_path(@question_response.question)
      else
        redirect_to new_user_registration_path(question_response: @question_response.slug)
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  private

  def question_response_params
    params.require(:question_response).permit(:body, :question_id)
  end
end
