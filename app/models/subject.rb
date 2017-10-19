class Subject < ApplicationRecord
  belongs_to :category
  has_many :posts, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates_uniqueness_of :name, scope: :category

  mount_uploader :cover, ImageUploader
end
