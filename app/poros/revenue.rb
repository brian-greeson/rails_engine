class Revenue
  def self.most(params)
    model_name = model_name_from(params)
    num_of_results = params[:quantity]
    if model_name == "items"
      Item.joins(:transactions).
      where(transactions: {result: :success}).
      select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").
      group(:id).
      order("revenue DESC").
      limit(num_of_results)
    elsif model_name == "merchants"
      Merchant.joins(:invoice_items, :transactions).
      where(transactions: {result: :success}).
      select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").
      group(:id).
      order("revenue DESC").
      limit(num_of_results)
    end
  end

  private
  
  def self.model_name_from(params)
    params[:controller].split("/")[2]
  end

  # def self.model_class_from(name)
  #   name.singularize.camelize.constantize
  # end
end