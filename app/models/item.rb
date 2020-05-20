class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  validates_presence_of :name, :description, :unit_price

  def self.find_match(params)
    result = nil
    params.each do |column, search|
      result = where("#{column} ILIKE ?", "%#{search}%")
      break if !result.empty?
    end
    result.first
  end
end

