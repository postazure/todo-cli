class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
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
        rename_t: "'rename' to rename a task",
        complete_t: "'complete' to complete a task and remove it from the list"
      }
    }
    @project_list = {}
    @working_task = ""
  end

  def real_puts message = ""
    $stdout.puts message
  end

  def prompt
    print "#{@working_project} >"
  end

  def print_menu menu_name
    puts
    @instructions[menu_name].each do |action, option|
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
      @working_task = "" if menu_level == "_t"
      @working_project = "" if menu_level == "_p"

      print_menu menu_name
      user_input = gets.chomp
      break if user_input == "quit"
      break if (user_input == "back" && menu_name != :project_menu)

      @working_project =  "" if menu_name == :project_menu
      if @instructions[menu_name].include?("#{user_input}#{menu_level}".to_sym)
        public_send("#{user_input}#{menu_level}".to_sym)
      else
        puts "Invalid Input!!!"
      end
    end

  end

  def list level
    key = {"_p" => "project", "_t" => "task"}[level]

    if key == "project"
      print "Projects:\n"
      if @project_list.empty?
        puts "  none"
      else
        @project_list.each do |project_id, object|
          print "  #{object.name}"
        end
      end

    elsif key == "task"
      if @project_list[@working_project].tasks.empty?
        puts "  none"
      else
        print "Tasks:"
        @project_list[@working_project].tasks.each do |task_id, object|
          print "\n  #{object.name}"
          print ": completed" if object.complete
        end
      end
    end
  end

  def create level
    key = {"_p" => "project", "_t" => "task"}[level]
    puts "Please enter the new #{key} name:\n"; prompt
    name = gets.chomp

    if key == "project"
      @project_list[name] = Project.new(name)
    else
      @project_list[@working_project].add_task(name)
    end
  end


  def rename_p
    puts "Please enter the project name to rename:\n"; prompt
    @working_project = gets.chomp
    if (@project_list.map {|project_id, object| object.name}).include?(@working_project)
      puts "Please enter the new project name:\n"; prompt
      new_name = gets.chomp

      @project_list[@working_project].rename(new_name)
    end
  end

  def rename_t
    puts "Please enter the task name to rename:\n"; prompt
    @working_task = gets.chomp
    tasks = @project_list[@working_project].tasks

    if tasks.map {|task_id, object| object.name}.include?(@working_task)
      puts "Please enter the new task name:\n"; prompt
      new_name = gets.chomp

      tasks[@working_task].rename(new_name)
    else
      puts "task not found: '#{@working_task}'"
    end
  end

  def delete_p
    puts "Please enter the project name to delete:\n"; prompt
    @working_project = gets.chomp
    if @project_list.include?(@working_project)
      @project_list.delete(@working_project)
    end
  end

  def edit_p
    puts "Please enter the project name to edit:\n"; prompt
    @working_project = gets.chomp
    if @project_list.include?(@working_project)
      puts "Editing Project: #{@working_project}"
      menu :task_menu
    end
  end

  def complete_t
    puts "Please enter the task name to complete:\n"; prompt
    @working_task = gets.chomp
    tasks = @project_list[@working_project].tasks
    if tasks.map {|task_id, object| object.name}.include?(@working_task)
      tasks[@working_task].set_complete
    else
      puts "task not found: '#{@working_task}'"
    end
  end
end
