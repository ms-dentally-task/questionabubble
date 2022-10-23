# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user, optional: true

  validates_presence_of :body, message: 'Please enter some text for your question.'
  validates :slug, presence: true
end
