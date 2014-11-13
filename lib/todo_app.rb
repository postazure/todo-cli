class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @project_list = {}
    @instructions = {
      project_menu: {
        list_p:  "'list' to list projects",
        create_p: "'create' to create a new project",
        rename_p: "'rename' to rename a project",
        delete_p: "'delete' to delete a project",
        edit_p: "'edit' to edit a project"
      },
      task_menu: {
        list_t: "'list' to list tasks",
        create_t: "'create' to create a new task",
        edit_t: "'edit' to edit a task",
        complete_t: "'complete' to complete a task and remove it from the list"
      }
    }
  end

  def real_puts message = ""
    $stdout.puts message
  end

  def get_input
    gets.chomp
  end

  def prompt project = @working_project
    print "#{project} >"
  end


  def print_menu instructions
    puts
    puts ".::: Menu :::."
    instructions.each_value do |option|
      puts option + "\n"
    end
    prompt
  end

  def run
    puts "Welcome"
    menu
  end

  def menu menu_name = :project_menu #:project_menu is main menu
    menu_level = {project_menu: "_p", task_menu: "_t"}[menu_name]

    while true
      @working_project =  "" if menu_name == :project_menu

      print_menu(@instructions[menu_name])
      user_input = get_input

      break if user_input == "quit"
      break if (user_input == "back" && menu_name != :project_menu)

      method = "#{user_input}#{menu_level}"
      actions = {
        "list_p" => lambda{list(menu_level,@project_list)},
        "list_t" => lambda{list(menu_level,@project_list[@working_project].tasks)},
        "create_p" => lambda{create(menu_level, @project_list)},
        "create_t" => lambda{create(menu_level, @project_list[@working_project])},
        "rename_p" => lambda{rename(menu_level,@project_list)},
        "edit_t" => lambda{rename(menu_level,@project_list[@working_project].tasks)},
        "delete_p" => lambda{delete_p},
        "edit_p" => lambda{edit_p},
        "complete_t" => lambda{complete_t}
      }
      actions[method].call if actions.include?(method)
    end
  end

  def list level, data
    print "#{{"_p" => "Projects:", "_t" => "Tasks:"}[level]}"
    if data.empty?
      puts "\n  none"
    else
      data.each_value do |object|
        print "\n  #{object.name}"
        print"#{': completed' if object.complete}" if level == "_t"
      end
    end
  end

  def create level, data
    level_out = {"_p" => "project", "_t" => "task"}[level]
    puts "Please enter the new #{level_out} name:\n"; prompt
    name = get_input

    data.add_task(name) if level == "_t"
    data[name] = Project.new(name) if level == "_p"
  end

  def rename level, data
    level_out = {"_p" => "project", "_t" => "task"}[level]
    puts "Please enter the #{level_out} name to rename:\n"; prompt
    old_name = get_input
    if (data.map {|project_id, object| object.name}).include?(old_name)
      @working_project = old_name if level == "_p"
      puts "Please enter the new #{level_out} name:\n"; prompt
      data[old_name].rename(get_input)
    else
      puts "#{level_out} not found: '#{old_name}'"
    end

  end

  def delete_p
    puts "Please enter the project name to delete:\n"; prompt
    @working_project = get_input
    if @project_list.include?(@working_project)
      @project_list.delete(@working_project)
    end
  end

  def edit_p
    puts "Please enter the project name to edit:\n"; prompt
    @working_project = get_input
    if @project_list.include?(@working_project)
      puts "Editing Project: #{@working_project}"
      menu :task_menu
    end
  end

  def complete_t
    puts "Please enter the task name to complete:\n"; prompt
    @working_task = get_input
    tasks = @project_list[@working_project].tasks
    if tasks.map {|task_id, object| object.name}.include?(@working_task)
      tasks[@working_task].set_complete
    else
      puts "task not found: '#{@working_task}'"
    end
  end
end
