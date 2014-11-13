require "./lib/store"
require "pry"
RSpec.describe Store do
  # provided tuple (orderId, companyName, customerAdress, orderedItem)
  # translated to headers as it usually comes from csv
  headers = [:orders,:companies,:addresses,:purchases]

  # provided file
  file_to_parse = "./spec/fixtures/orders.txt"

  gw = Store::Gateway.new(file_to_parse)
  mapper = Store::Mapper.new(gw, headers)

  it "should read file" do
    expect(gw.read_orders.size).to eq 8
  end
  it "returns list of parsed orders" do
    orders = mapper.orders
    expect(orders.first.kind_of? Hash).to be true
  end

  # actual request

  it "show all orders from a particular company" do
    orders = mapper.orders_from_company("SuperTrader")
    expect(orders.size).to eq 4
  end

  it "show all orders to a particular address" do
    orders = mapper.orders_for_address("Reeperbahn 153")
    expect(orders.size).to eq 3
  end

  it "delete a particular order given an OrderId" do
    mapper.delete_order("001")
    expect(mapper.orders.size).to eq 7
  end

  it "display how often each item has been ordered, in descending order" do
    purchases = mapper.purchases_as_ordered
    expect(purchases.first[:order_ids].size).to eq 2
  end

end