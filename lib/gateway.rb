module Store
  class Gateway
    def initialize(file_path)
      @file_path = file_path
    end
    def read_orders
      # enumerable reading should suffice for small file
      # current implementation stores entire orders array in memomory 
      # before processing
      # 
      # big files are considered an edge case
      # although can be taken care of with enumerable 
      # Store::Mapper#parse_orders called on each line as it read
      # considering limited subsets of data requests 
      # orders.take(2) will read only 2 lines of given file
      lines = []
      file = File.open(@file_path, 'r')
      file.each_line { |line| lines << line }
      file.close
      lines
    end
  end
end