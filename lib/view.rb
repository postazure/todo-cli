class View
  attr_reader :output

  def initialize(output)
    @output = output
  end
  
  def puts(message)
    output.puts(message)
  end
end
