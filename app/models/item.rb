class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  validates_presence_of :name, :description, :unit_price
end
