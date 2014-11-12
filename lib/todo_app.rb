class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @tasks = []
  end
  # def real_puts message = ""
  #   $stdout.puts message
  # end

  def menu_print_main
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"
    puts "'delete' to rename a project"
  end

  def menu_print_task
    puts "Editing Project: #{print_list(@projects)}"
    puts "'list' to list tasks"
    puts "'create' to create a new task"
    puts "'edit' to edit a task"
    puts "'complete' to complete a task and remove it from the list"
  end

  def project_print_list
    puts "Projects:\n  #{print_list(@projects)} "
  end
  def task_print_list
    puts "  #{print_list(@tasks)}"
  end
  def print_list(some_array)
    some_array.empty? ? "none" : some_array.map {|name| name}.join
  end

  def project_print_create
    puts "Please enter the new project name:\n"
  end
  def task_print_create
    puts "Please enter the task you would like to add."
  end

  def project_print_delete
    puts "Please enter the project name to delete:\n"
  end
  def task_print_complete
    puts "Which task have you completed?"
  end

  def project_print_rename
    puts "Please enter the project name to rename:\n"
  end
  def task_print_rename
    puts "Please enter the task you would like to edit."
  end

  def project_print_rename_new
    puts "Please enter the new project name:\n"
  end
  def task_print_rename_new
    puts "Please enter the new task name:\n"
  end

  def project_print_edit
    puts "Which project would you like to edit?\n"
  end

  def task_print_alert
    puts "task not found: 'not here'"
  end

#----Data Handlers
  def project_data_create project_name
    @projects << project_name
  end
  def task_data_create task_name
    @tasks << task_name
  end

  def project_data_delete project_name
    @projects.delete(project_name)
  end

  def project_data_rename old_name, new_name
    @projects.delete(old_name)
    @projects << new_name
  end
  def task_data_rename old_name, new_name
    @tasks.delete(old_name)
    @tasks << new_name
  end
  def task_data_complete name
    name = "#{name}: completed"
    @tasks << name
  end
#^^^^^^^^^^^^^^^^

  def valid_(type, name)
    type.include?(name)
  end

  def get_input
    gets.chomp
  end


  def run
    puts "Welcome"
    menu_print_main
    welcome_menu = true
    while welcome_menu
      input = gets.chomp
      if input == 'list'
        project_print_list

      elsif input == 'create'
        project_print_create
        project_data_create(get_input)
        menu_print_main

      elsif input == 'delete'
        project_print_delete
        project_name = get_input
        project_data_delete(project_name) if valid_(@projects, project_name)

      elsif input == 'rename'
        project_print_rename
        project_name = get_input
        if valid_(@projects, project_name)
          project_print_rename_new
          project_data_rename(project_name, get_input)
        end

      elsif input == 'edit'
        project_print_edit
        run_task_menu if valid_(@projects, get_input)
      elsif input == 'quit'
        welcome_menu = false
      end
    end
  end

  def run_task_menu
    menu_print_task
    task_menu = true
    while task_menu
      task_input = get_input
      if task_input == 'list'
        task_print_list
      elsif task_input == 'create'
        task_print_create
        task_data_create(get_input)
      elsif task_input == 'edit'
        task_print_rename
        task_name = get_input

        if valid_(@tasks, task_name)
          task_print_rename_new
          task_data_rename(task_name, get_input)
        else
          task_print_alert
        end
      elsif task_input == 'complete'
        task_print_complete
        task_name = get_input
        valid_(@tasks, task_name) ? task_data_complete(task_name) : task_print_alert
      elsif task_input == 'back'
        menu_print_main
        task_menu = false
      elsif task_input == 'quit'
        welcome_menu = false
        task_menu = false
      end
    end
  end
end
