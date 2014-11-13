class TodoApp < CommandLineApp
  extend Forwardable
  attr_reader :model_project, :model_task, :view_task, :view_project
  def initialize(input, output)
    @input = input
    @output = output
    @view_project = ViewProject.new(output)
    @view_task = ViewTask.new(output)
    @model_project = ModelProject.new
    @model_task = ModelTask.new
  end

  def_delegators :model_project,
    :projects,
    :project_add,
    :project_delete,
    :project_present?,
    :project_rename
  def_delegators :view_project,
    :print_projects_list,
    :print_project_create_prompt,
    :print_project_menu,
    :print_project_delete_prompt,
    :print_project_rename_prompt,
    :print_prompt_for_new_project_name,
    :print_project_edit_prompt
  def_delegators :model_task,
    :tasks,
    :add_task,
    :task_present?,
    :complete_task,
    :task_rename
  def_delegators :view_task,
    :print_task_menu,
    :print_tasks_list,
    :print_new_task_prompt,
    :print_task_edit_prompt,
    :print_prompt_for_new_task_name,
    :print_task_not_here_message

  def run
    print_project_menu

    welcome_menu = true
    while welcome_menu
      input = get_input


      if input == 'list'
        print_projects_list(projects)
      elsif input == 'create'
        print_project_create_prompt
        project_add(get_input)
        print_project_menu
      elsif input == 'delete'
        print_project_delete_prompt
        project_delete(get_input)
      elsif input == 'rename'
        print_project_rename_prompt
        if project_present?(old_name = get_input)
          print_prompt_for_new_project_name
          project_rename(old_name, get_input)
        end
      elsif input == 'edit'
        print_project_edit_prompt
        project_name = get_input
        if project_present?(project_name)
          run_task_menu(project_name)
          print_task_menu(project_name)
        end
      elsif input == 'quit'
        welcome_menu = false
      end
    end
  end

  def run_task_menu(project_name)
    print_task_menu(project_name)

    task_menu = true

    while task_menu


      task_input = get_input
      if task_input == 'list'
        print_tasks_list(tasks)
      elsif task_input == 'create'
        print_new_task_prompt
        add_task(get_input)
      elsif task_input == 'edit'
        print_task_edit_prompt
        old_name = get_input
        if task_present?(old_name)
          print_prompt_for_new_task_name
          task_rename(old_name, get_input)
        else
          print_task_not_here_message(old_name)
        end
      elsif task_input == 'complete'
        complete_task = get_input
        if task_present?(complete_task)
          complete_task(complete_task)
        else
          print_task_not_here_message(complete_task)
        end
      elsif task_input == 'back'
        print_project_menu
        task_menu = false
      end
    end
  end
end
