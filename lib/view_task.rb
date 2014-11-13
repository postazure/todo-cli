class ViewTask < View

  def print_task_menu(project_name)
    puts "Editing Project: #{project_name} "
    puts "'list' to list tasks"
    puts "'create' to create a new task"
    puts "'edit' to edit a task"
    puts "'complete' to complete a task and remove it from the list"
  end


  def print_tasks_list(tasks)
    puts "Tasks:"
    if tasks.empty?
      puts "  none"
    else
      puts "  #{tasks.join(', ')}"
    end
  end

  def print_task_edit_prompt
    puts "Please enter the task you would like to edit."
  end

  def print_prompt_for_new_task_name
    puts "Please enter the new task name:\n"
  end

  def print_task_not_here_message(name)
    puts "task not found: '#{name}'"
  end

  def print_new_task_prompt
    puts "Please enter the task you would like to add."
  end
end
