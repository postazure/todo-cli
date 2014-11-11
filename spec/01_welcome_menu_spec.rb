require 'spec_helper'

describe TodoApp do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { TodoApp.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe "The Welcome Menu" do
    it "includes 'Welcome'" do
      simulate_user_input("quit")
      app.run

      expect(output).to include("Welcome")
    end

    it "include instructions for listing projects" do
      simulate_user_input("quit")
      app.run

      expect(output).to include("'list' to list projects")
    end

    it "include instructions for creating projects" do
      simulate_user_input("quit")
      app.run

      expect(output).to include("'create' to create a new project")
    end

    it "include instructions for renaming projects" do
      simulate_user_input("quit")
      app.run

      expect(output).to include("'rename' to rename a project")
    end
  end
end
