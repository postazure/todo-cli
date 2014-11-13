require 'spec_helper'

describe TodoApp do
  # Don't mind all this crazy setup, testing command line apps is hard!
  let(:io_input)  { StringIO.new("") }
  let(:io_output) { StringIO.new("") }

  let(:app) { TodoApp.new(io_input, io_output) }
  let(:output) { io_output.string }

  describe 'creating tasks within a project' do
    let(:project_setup_commands) { ['create', "Chores", "edit", "Chores"] }
    let(:task_creation_commands) { ['create', 'do the laundry', 'create', 'iron shirts'] }

    describe 'new menu when editing a project' do
      it "includes the project name" do
        simulate_user_input(project_setup_commands, 'back', 'quit')
        app.run

        expect(output).to include("Editing Project: Chores")
      end

      it "gives instruction for listing tasks" do
        simulate_user_input(project_setup_commands, 'back', 'quit')
        app.run

        expect(output).to include("'list' to list tasks")
      end

      it "gives instructions for other tasks" do
        simulate_user_input(project_setup_commands, 'back', 'quit')
        app.run

        expect(output).to include("'create' to create a new task")
        expect(output).to include("'edit' to edit a task")
        expect(output).to include("'complete' to complete a task and remove it from the list")
      end
    end

    describe 'going back' do
      it "reprints the projects instructions" do
        simulate_user_input(project_setup_commands, 'back', 'quit')
        app.run

        expect(output.scan(/'list' to list projects/).count).to be == 3
      end
    end

    describe 'listing' do
      describe 'when there are no tasks' do
        it "does not show projects" do
          simulate_user_input(project_setup_commands,'list', 'back', 'quit')
          app.run

          expect(output).to_not include("Projects:\n  Chores")
        end

        it "shows 'none'" do
          simulate_user_input(project_setup_commands,'list', 'back', 'quit')
          app.run

          expect(output).to include("  none")
        end
      end

      describe 'when tasks have been created' do
        before do
          simulate_user_input(project_setup_commands, task_creation_commands, 'list', 'back', 'quit')
        end

        it "should not show projects" do
          app.run
          expect(output).to_not include("Projects:\n  Chores")
        end

        it "should show new tasks" do
          app.run
          expect(output).to include("do the laundry")
          expect(output).to include("iron shirts")
        end
      end
    end

    describe 'editing a task' do
      describe 'when the task is found' do
        before do
          simulate_user_input(
            project_setup_commands,
            task_creation_commands,
            'edit', 'iron shirts', 'iron clothes', 'list', 'back', 'quit'
          )
        end

        it "should update the task in the list" do
          app.run
          expect(output).to include("iron clothes")
          expect(output).not_to include("iron shirts")
        end
      end

      describe 'when the task is not found' do
        before do
          simulate_user_input(
            project_setup_commands,
            task_creation_commands,
            'edit', 'not here', 'back', 'quit'
          )
        end

        it "should report and return to normal menu" do
          app.run
          expect(output).to include("task not found: 'not here'")
        end
      end
    end

    describe 'completing a task' do
      describe 'when task is found' do
        before do
          simulate_user_input(
            project_setup_commands,
            task_creation_commands,
            'complete', 'do the laundry', 'list', 'back', 'quit'
          )
        end

        it "should list the task as completed" do
          app.run
          expect(output).to include("do the laundry: completed")
        end
      end

      describe 'when task is not found' do
        before do
          simulate_user_input(
            project_setup_commands,
            task_creation_commands,
            'complete', 'not here', 'list', 'back', 'quit'
          )
        end

        it "should still have all its tasks" do
          app.run
          expect(output).to include('do the laundry')
          expect(output).to include('iron shirts')
        end

        it "should report that it couldn't find the task" do
          app.run
          expect(output).to include("task not found: 'not here'")
        end
      end
    end
  end
end
