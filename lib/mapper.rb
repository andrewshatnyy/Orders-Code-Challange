module Store
  class Mapper

    # Mapper / Storage class
    # 
    # stores collection of records in a hash
    # based on order id to implement fast 
    # hash key lookups @map[type_of_record][id]
    # in comparison to array search
    # 
    # Order record is one saved without relation
    # 
    # Other records have :order_ids as one to many (simplified reference)
    # allowing to fetch orders based on "ids"
    # see :orders_from_company method


    def initialize(gateway, headers)
      @gateway = gateway
      @headers = headers

      create_map
      parse_orders(@gateway.read_orders)
    end

    def orders
      @map[:orders].values
    end

    def delete_order(id)
      # simple hash key delete
      @map[:orders].delete(id)
    end

    def orders_from_company(company)
      # deleted orders nil values 
      # are concidered as an edge case
      # [order, nil, order]
      # 
      # can be resolved with each and accumulator
      ids = @map[:companies][company][:order_ids]
      ids.map {|id| @map[:orders][id]}
    end

    def orders_for_address(address)
      ids = @map[:addresses][address][:order_ids]
      ids.map {|id| @map[:orders][id]}
    end

    def purchases_as_ordered
      # use Schwartzian transform here to cash [:order_ids].size and reduce N
      @map[:purchases].values.sort_by {|i| -i[:order_ids].size }
    end

    private

    def parse_orders(order_strings)
      # assuming specs require all records to be fetched at once,
      # hence no enumerable calls (like mapper.orders.take(2) => [ord1, ord2])
      order_strings.map do |order_string|
        order_string.strip!
        store_data(order_string.split(/\s?,\s?/))
      end
    end

    def create_map
      # creates map based on headers
      @map = {}
      @headers.each { |key| @map[key] = {} }
    end

    def store_data(args)
      @headers.each_with_index do |type, index|
        store_type(type, args, index)
      end
      @map[:orders]
    end

    def store_type(type, args, index)
      # Sinse all operations requested on "data structure in memory" (per spec.)
      # Assuming no operations where required to be called on Instances of Records
      # Like Orders.all / Company.find("Name").orders (considering this as an edge case)
      # Structs / Classes for Records are omitted using basic Hash for simplisity
      
      if index == 0
        # assuming orders are sequential, hence no detection old records
        id, company, address, purchase = args
        @map[:orders][id] = {
          id: id,
          company: company,
          address: address,
          purchase: purchase
        }
      else
        new_record = false
        name = args[index]

        other = @map[type].fetch(name) do
          new_record = true
          {
            name: name,
            order_ids: []
          }
        end
        other[:order_ids] << args[0]
        # don't mutate unless new record
        @map[type][name] = other if new_record
      end
    end
  end
end