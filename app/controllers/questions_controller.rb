# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      head :created
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
end
