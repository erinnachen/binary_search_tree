require 'null_node'
class Node
  attr_reader :value, :left_link,:right_link

  def initialize(data_in = [])
    @value = data_in
    @left_link = NullNode.new
    @right_link = NullNode.new
  end

  def change_left_link(link)
    @left_link = link
  end

  def change_right_link(link)
    @right_link = link
  end

  def is_leaf?
    right_link.nil? && left_link.nil?
  end

  def only_has_right_branch?
    right_link && left_link.nil?
  end

  def only_has_left_branch?
    right_link.nil? && left_link
  end

  def insert(data)
    if data > value
      @right_link, depth = right_link.insert(data)
    elsif data < value
      @left_link, depth = left_link.insert(data)
    else
      depth = -1
    end
    [self, depth+1]
  end

  def include?(data)
    data == value || left_link.include?(data) ||right_link.include?(data)
  end

  def max
    if right_link.nil?
      value
    else
      right_link.max
    end
  end

  def min
    if left_link.nil?
      value
    else
      left_link.min
    end
  end

  def depth_of(data)
    if data == value
      0
    elsif data > value
      1 + right_link.depth_of(data) unless right_link.depth_of(data).nil?
    elsif data < value
      1 + left_link.depth_of(data) unless left_link.depth_of(data).nil?
    end
  end

  def sort
    if is_leaf?
      [value]
    elsif only_has_right_branch?
      [value]+right_link.sort
    elsif only_has_left_branch?
      left_link.sort+[value]
    else
      left_link.sort+[value]+right_link.sort
    end
  end

  def leaves
    if is_leaf?
      1
    else
      left_link.leaves + right_link.leaves
    end
  end

  def height
    1+[left_link.height, right_link.height].max
  end

  def delete(data)
    if value == data
      if is_leaf?
        [NullNode.new(), data]
      elsif only_has_right_branch?
        [right_link, data]
      elsif only_has_left_branch?
        [left_link, data]
      else
        @value = left_link.max
        @left_link, d1 = left_link.delete(value)
        [self, data]
      end
    elsif data > value
      @right_link, del = right_link.delete(data)
      [self, del]
    else data < value
      @left_link, del = left_link.delete(data)
      [self, del]
    end
  end

end
