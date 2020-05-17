require 'csv'
require 'pry'

CSV_PATH = "#{Rails.root}/lib/assets/"
namespace :db do
  task import_csv: :environment do
    def print_and_flush(content)
      print "   \r    " + content 
      $stdout.flush
    end

    puts "Reseting Database"

    ActiveRecord::Base.connection.tables.each do |t|
      if t != "schema_migrations" && t != "ar_internal_metadata"
        puts "Destroying records in #{t} table "
        t.singularize.camelize.constantize.destroy_all
        puts "Reseting PK on #{t} table"
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
    end

    puts "Loading Merchants from CSV: "
    row_count = `wc -l < #{CSV_PATH}merchants.csv`.to_f 
    CSV.foreach("#{CSV_PATH}merchants.csv", headers: true).with_index do |row, ln|
      Merchant.create!(row.to_h)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end
    print_and_flush("100% \n")
    
    puts "Loading Customers from CSV: "
    row_count = `wc -l < #{CSV_PATH}customers.csv`.to_f 
    CSV.foreach("#{CSV_PATH}customers.csv", headers: true).with_index do |row, ln|
      Customer.create!(row.to_h)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end   
    print_and_flush("100% \n")

    puts "Loading Items from CSV: "
    row_count = `wc -l < #{CSV_PATH}items.csv`.to_f 
    CSV.foreach("#{CSV_PATH}items.csv", headers: true).with_index do |row, ln|
      row = row.to_h
      row["unit_price"] = row["unit_price"].to_f / 10
      Item.create!(row)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end
    print_and_flush("100% \n")

    puts "Loading Invoices from CSV: "
    row_count = `wc -l < #{CSV_PATH}invoices.csv`.to_f 
    CSV.foreach("#{CSV_PATH}invoices.csv", headers: true).with_index do |row, ln|
      Invoice.create!(row.to_h)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end
    print_and_flush("100% \n")

    puts "Loading Invoice Items from CSV: "
    row_count = `wc -l < #{CSV_PATH}invoice_items.csv`.to_f 
    CSV.foreach("#{CSV_PATH}invoice_items.csv", headers: true).with_index do |row, ln|
      row = row.to_h
      row["unit_price"] = row["unit_price"].to_f / 10
      InvoiceItem.create!(row)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end
    print_and_flush("100% \n")

    puts "Loading Transactions from CSV: "
    row_count = `wc -l < #{CSV_PATH}transactions.csv`.to_f 
    CSV.foreach("#{CSV_PATH}transactions.csv", headers: true).with_index do |row, ln|
      Transaction.create!(row.to_h)
      print_and_flush("#{(ln / row_count * 100).to_i}%")
    end
    print_and_flush("100% \n")
  
  end
end