class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  validates_presence_of :name

  def self.find_match(params)
    result = nil
    params.each do |column, search|
      result = where("#{column} ILIKE ?", "%#{search}%")
      break if !result.empty?
    end
    result.first
  end
end
