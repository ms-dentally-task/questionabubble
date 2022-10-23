# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = Vote.new(vote_params.merge(user: current_user))
    if @vote.save
      render status: :created
    else
      head status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @voteable = @vote.voteable

    if @vote.destroy
      render status: :ok
    else
      head status: :unprocessable_entity
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:voteable_id, :voteable_type)
  end
end
