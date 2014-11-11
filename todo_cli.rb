require_relative "./lib/command_line_app"
require_relative "./lib/todo_app"
require_relative "./lib/project"
require_relative "./lib/task"

TodoApp.new($stdin, $stdout).run
