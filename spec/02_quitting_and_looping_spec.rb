require 'spec_helper'

describe TodoApp do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { TodoApp.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe "quitting and looping" do
    it "the program exits when the user types 'quit'" do
      expect_user_input('quit')
      app.run

      # if the test fails, you will get stuck in a loop here
      # you can press ctrl+c to get out of it
    end



    it "the program keeps going until the user types 'quit'" do
      expect_user_input('gerbil', 'fish', 'quit')
      app.run

      # if the test fails, you will get stuck in a loop here
      # you can press ctrl+c to get out of it
    end
  end
end
