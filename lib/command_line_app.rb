class CommandLineApp
  attr_reader :input, :output

  def puts(message = "")
    output.puts(message)
  end

  def print(message)
    output.print(message)
  end

  def gets
    input.gets
  end

  def initialize(input, output)
    @input = input
    @output = output
  end
end
