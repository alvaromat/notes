class Note < ApplicationRecord
  COLORS = [%w(Yellow #FFF176), %w(Green #AED581), %w(Pink #F06292)]

  validates :title, presence: true, length: {minimum: 3}
  validates :body, presence: true
  validates :color, presence: true
  belongs_to :user
end
