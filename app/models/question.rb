# frozen_string_literal: true

class Question < ApplicationRecord
  before_validation :create_slug, if: -> { slug.blank? }

  belongs_to :user, optional: true

  validates_presence_of :body, message: 'Please enter some text for your question.'
  validates :slug, presence: true

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = SecureRandom.hex(5)
  end
end
