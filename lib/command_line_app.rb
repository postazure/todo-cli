class CommandLineApp
  attr_reader :input, :output

  def puts(message)
    output.puts(message)
  end

  # def gets
  #   input.gets
  # end

  def get_input
    input.gets.chomp
  end

  def real_puts message = ""
    $stdout.puts message
  end

end
