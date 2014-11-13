class TodoApp < CommandLineApp
  attr_reader :projects, :tasks

  def initialize(input, output)
    @input = input
    @output = output

  end

  def get_input
    gets.chomp
  end

  def project_add(name)
    projects << name
  end

  def project_delete(name)
    if project_present?(name)
      projects.delete(name)
    end
  end

  def project_present?(name)
    projects.include?(name)
  end

  def project_rename(old_name, new_name)
    projects.delete(old_name)
    projects << new_name
  end

  def add_task(name)
    tasks << name
  end

  def task_present?(name)
    tasks.include?(name)
  end

  def task_rename(old_name, new_name)
    tasks.delete(old_name)
    tasks << new_name
  end

  def complete_task(name)
    tasks.delete(name)
    completed_task = "#{name}: completed"
    tasks << completed_task
  end

  def run
    @projects = []
    @tasks = []
    ViewProject.new(output).print_project_menu

    welcome_menu = true

    while welcome_menu
      input = get_input

      if input == 'list'
        ViewProject.new(output).print_projects_list(projects)
      elsif input == 'create'
        ViewProject.new(output).print_project_create_prompt
        project_add(get_input)
        ViewProject.new(output).print_project_menu
      elsif input == 'delete'
        ViewProject.new(output).print_project_delete_prompt
        project_delete(get_input)
      elsif input == 'rename'
        ViewProject.new(output).print_project_rename_prompt
        if project_present?(old_name = get_input)
          ViewProject.new(output).print_prompt_for_new_project_name
          project_rename(old_name, get_input)
        end
      elsif input == 'edit'
        ViewProject.new(output).print_project_edit_prompt
        project_name = get_input
        if project_present?(project_name)
          run_task_menu(project_name)
          ViewTask.new(output).print_task_menu(project_name)
        end
      elsif input == 'quit'
        welcome_menu = false
      end
    end
  end

  def run_task_menu(project_name)
    ViewTask.new(output).print_task_menu(project_name)

    task_menu = true

    while task_menu
      task_input = get_input
      if task_input == 'list'
        ViewTask.new(output).print_tasks_list(tasks)
      elsif task_input == 'create'
        ViewTask.new(output).print_new_task_prompt
        add_task(get_input)
      elsif task_input == 'edit'
        ViewTask.new(output).print_task_edit_prompt
        old_name = get_input
        if task_present?(old_name)
          ViewTask.new(output).print_prompt_for_new_task_name
          task_rename(old_name, get_input)
        else
          ViewTask.new(output).print_task_not_here_message(old_name)
        end
      elsif task_input == 'complete'
        complete_task = get_input
        if task_present?(complete_task)
          complete_task(complete_task)
        else
          ViewTask.new(output).print_task_not_here_message(complete_task)
        end
      elsif task_input == 'back'
        ViewProject.new(output).print_project_menu
        task_menu = false
      end
    end
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
