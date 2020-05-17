class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items


  validates_presence_of :status, :customer_id, :merchant_id

  enum status: [:pending, :fulfilled, :shipped, :canceled]
end
