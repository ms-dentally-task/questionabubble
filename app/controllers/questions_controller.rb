# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      head :created
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
