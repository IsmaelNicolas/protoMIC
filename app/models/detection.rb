class Detection < ApplicationRecord
  has_one_attached :image
  enum severity: { low: 0, medium: 1, high: 2 }
end
