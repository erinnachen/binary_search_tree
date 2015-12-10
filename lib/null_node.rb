require 'node'

class NullNode
  def nil?
    true
  end

  def include?(data)
    false
  end

  def max
    nil
  end

  def min
    nil
  end

  def sort
    nil
  end

  def depth_of(data)
    nil
  end

  def insert(data)
    [Node.new(data), 0]
  end

  def leaves
    0
  end

  def height
    0
  end

  def delete(data)
    [self, nil]
  end

end
