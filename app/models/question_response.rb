# frozen_string_literal: true

class QuestionResponse < ApplicationRecord
  before_validation :create_slug, if: -> { slug.blank? }

  belongs_to :question
  belongs_to :user, optional: true

  has_many :votes, as: :voteable

  validates_presence_of :body, message: 'Please enter some text for your answer.'

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = SecureRandom.hex(5)
  end
end
