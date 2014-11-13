class ViewProject < View
  
  def print_project_menu
    puts "Welcome"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"
    puts "'delete' to rename a project"
  end

  def print_projects_list(projects)
    puts "Projects:"
    if projects.empty?
      puts "  none"
    else
      puts "  #{projects.join(', ')}"
    end
  end

  def print_project_create_prompt
    puts "Please enter the new project name:\n"
  end

  def print_project_delete_prompt
    puts "Please enter the project name to delete:\n"
  end

  def print_project_rename_prompt
    puts "Please enter the project name to rename:\n"
  end

  def print_prompt_for_new_project_name
    puts "Please enter the new project name:\n"
  end

  def print_project_edit_prompt
    puts "Which project would you like to edit?\n"
  end
end
