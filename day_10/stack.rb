class Stack
  def initialize
    @array = []
  end

  def push(element)
    array.push(element)
  end

  def pop
    array.pop
  end

  private

  attr_accessor :array
end
