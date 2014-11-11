require 'spec_helper'

describe TodoApp do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { TodoApp.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe 'working with projects' do
    describe "listing projects" do
      it "shows an empty list when there are no projects" do
        simulate_user_input("list", "quit")
        app.run

        expect(output).to include("Projects:\n  none")
      end
    end

    describe 'creating projects' do
      it "new projects will show up in the list" do
        simulate_user_input("create", "Chores", "list", "quit")
        app.run

        expect(output).to include("Please enter the new project name:\n")
        expect(output).to include("Projects:\n  Chores")
      end
    end

    describe 'renaming projects' do
      it "existing projects can be renamed" do
        simulate_user_input(
          "create", "Chores",
          "rename", "Chores", "Groceries",
          "list",
          "quit"
        )
        app.run

        expect(output).to include("Please enter the project name to rename:\n")
        expect(output).to include("Please enter the new project name:\n")
        expect(output).to include("Projects:\n  Groceries")
      end
    end

    describe 'deleting projects' do
      it "existing projects can be removed" do
        simulate_user_input(
          "create", "Chores",
          "delete", "Chores",
          "list",
          "quit"
        )
        app.run

        expect(output).to include("Please enter the project name to delete:\n")
        expect(output).to include("Projects:\n  none")
      end
    end
  end
end
