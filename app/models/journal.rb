class Journal < ApplicationRecord
  belongs_to :subject

  validates :date, presence: true
  validates :content, presence: true

  validates_uniqueness_of :date, scope: :subject
end
