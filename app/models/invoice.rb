class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  validates_presence_of :status

  enum status: [:pending, :fulfilled, :shipped, :canceled]
end
