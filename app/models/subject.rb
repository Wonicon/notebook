class Subject < ApplicationRecord
  belongs_to :category
  has_many :posts, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
