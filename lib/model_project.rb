class ModelProject
  attr_reader :projects
  def initialize
    @projects = []
    
  end

  def project_add(name)
    projects << name
  end

  def project_present?(name)
    projects.include?(name)
  end

  def project_delete(name)
    if project_present?(name)
      projects.delete(name)
    end
  end

  def project_rename(old_name, new_name)
    projects.delete(old_name)
    projects << new_name
  end
end
