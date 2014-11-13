require "benchmark/bigo"
require "./lib/mapper"

Benchmark.bigo do |x|
  Gateway = Struct.new(:read_orders)
  gw = Gateway.new([])

  x.generator do |size|

    names = [', SuperTrader, Steindamm 80, Macbook',
      ', Cheapskates, Reeperbahn 153, Macbook',
      ', MegaCorp, Steindamm 80, Book "Guide to Hamburg"',
      ', SuperTrader, Sternstrasse  125, Book "Cooking  101"',
      ', SuperTrader, Ottenser Hauptstrasse 24, Inline Skates',
      ', MegaCorp, Reeperbahn 153, Playstation',
      ', Cheapskates, Lagerstrasse  11, Flux compensator',
      ', SuperTrader, Reeperbahn 153, Inline Skates'
    ]

    size.times do
      gw.read_orders << "00#{gw.read_orders.size+1}#{names[rand(names.size)]}"
    end

    Store::Mapper.new(gw, [:orders,:companies,:addresses,:purchases])

  end

  x.time = 20
  x.warmup = 2

  x.min_size = 200
  x.step_size = 200
  x.steps = 4 # 200..2000
  
  x.report("#list-orders") {|mapper, size| 
    mapper.orders
  }
  x.report("#from-company") {|mapper, size| 
    mapper.orders_from_company("SuperTrader")
  }

  x.report("#from-company") {|mapper, size| 
    mapper.orders_from_company("SuperTrader")
  }

  x.report("#to-address") {|mapper, sizde|
    mapper.orders_for_address("Reeperbahn 153")
  }
  
  x.report("#purchses-ordered-desc") {|mapper, sizde|
    mapper.purchases_as_ordered
  }

  x.compare!

  x.chart! 'big-o.html'
end