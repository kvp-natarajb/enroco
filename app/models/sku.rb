class Sku < ApplicationRecord
	validates :denomination, presence: true, numericality: { only_integer: true }
	validates :combination, presence: true

	belongs_to :user
end
