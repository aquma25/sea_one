class Court < ApplicationRecord
  # DB Relations
  has_many :court_members
  has_many :users, through: :court_members
  has_many :images, dependent: :destroy
end
