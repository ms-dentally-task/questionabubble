# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: :show

  def new
    @question = Question.new
  end

  def show
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      if @question.user
        redirect_to question_path(@question)
      else
        redirect_to new_user_registration_path(question: @question.slug)
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_question
    @question = Question.find_by!(slug: params[:id])
  end
end
