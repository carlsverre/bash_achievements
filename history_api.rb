history_file = "#{ENV['HOME']}/.bash_history"

class BashHistory
  attr_accessor :map

  def initialize history_file
    @history_file = history_file
    @map = {}
    lines = get_lines
    parse_lines lines
  end

  def get_lines
    IO.readlines(@history_file)
  end

  def parse_lines lines
    lines.each do |line|
      parts = line.split(/\s+/)
      if @map.include? parts[0]
        @map[parts[0]] += 1
      else
        @map[parts[0]] = 1
      end
    end
  end
end

b = BashHistory.new history_file
b.map = b.map.sort_by {|k,v| v}

b.map.each { |key,val|
  puts "#{key}: #{val}"
}

