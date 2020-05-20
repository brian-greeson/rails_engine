class Item < ApplicationRecord
  belongs_to :merchant
  
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price

  def self.find_match(params)
    find_matches(params).first
  end

  def self.find_matches(params)
    results = []
    params.each do |column, search|
      results << where("#{column} ILIKE ?", "%#{search}%")
    end
    results.flatten.uniq
  end
end

