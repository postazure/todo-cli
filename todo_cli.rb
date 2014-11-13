require_relative "./lib/command_line_app"
require_relative "./lib/todo_app"
require_relative "./lib/view"

TodoApp.new($stdin, $stdout).run
