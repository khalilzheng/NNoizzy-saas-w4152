class Sound < ApplicationRecord
  scope :curated, -> { where(is_curated: true) }

  validates :name, presence: true
  validates :file_url, presence: true
end
