class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  
  validates_presence_of :name

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
