require 'csv'
CSV_PATH = "/lib/assets"
namespace :db do
  namespace :import_csv do
    task import_items: :enviroment do
     CSV.foreach("#{csv_path}/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
     end
    end
  end
end