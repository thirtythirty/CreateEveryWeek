class Score < ApplicationRecord
  belongs_to :user
  belongs_to :contest

  scope :sort_by_point, -> { order(point: :DESC) }
  scope :sort_by_created_at, -> { order(created_at: :DESC) }
end
