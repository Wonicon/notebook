class Task < ApplicationRecord
  belongs_to :subject
  has_many :task_items, dependent: :destroy
end
