class Task < ApplicationRecord
  belongs_to :subject
  has_many :task_items, dependent: :destroy
  has_many :task_comments, dependent: :destroy

  validates :title, presence: true
end
