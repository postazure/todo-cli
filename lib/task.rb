class Task
  attr_reader :name, :complete
  def initialize name
    @name = name
    @complete = false
  end

  def rename name
    @name = name
  end

  def set_complete status = true
    @complete = status
  end
end
