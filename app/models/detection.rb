class Detection < ApplicationRecord
  has_one_attached :image
  enum severity: { low: 0, medium: 1, high: 2 }
  enum plague: { fresh_leaf: 0, downy_mildew: 1, black_spot: 2 }
end
