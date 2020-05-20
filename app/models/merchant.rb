class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  validates_presence_of :name

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
