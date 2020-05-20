class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  validates_presence_of :name, :description, :unit_price

  def self.find_match(params)
    find_matches(params).first
  end

  def self.find_matches(params)
    result = nil
    params.each do |column, search|
      result = where("#{column} ILIKE ?", "%#{search}%")
      break if !result.empty?
    end
    result
  end
end

