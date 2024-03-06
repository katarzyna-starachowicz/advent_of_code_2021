class Queue
  def initialize
    @queue = []
  end

  def enqueue(element)
    queue.push(element)
  end

  def dequeue
    queue.shift
  end

  private
  attr_accessor :queue
end
