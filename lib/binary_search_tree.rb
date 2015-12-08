require 'pry'
require_relative 'node'

class FileReader
  def read_numbers(filename)
    filein = File.read(filename).chomp
    filein.split.map {|num| num.to_i}.shuffle unless filein.empty?
  end
end

class BinarySearchTree
  attr_reader :root, :reader

  def initialize()
    @root = nil
    @reader = FileReader.new
  end

  def insert(data)
    if is_empty?
      @root = Node.new(data)
      depth = 0
    else
      insert_recursive(data,root)
    end
  end

  def insert_recursive(data,node)
    if node.value > data && node.left_link.nil?
      node.change_left_link(Node.new(data))
      depth = 1
    elsif node.value < data && node.right_link.nil?
      node.change_right_link(Node.new(data))
      depth = 1
    elsif node.value == data
      depth = 0
    elsif node.value > data
      depth = 1 + insert_recursive(data,node.left_link)
    else
      depth = 1 + insert_recursive(data,node.right_link)
    end
  end

  def include?(data)
    included = false
    unless is_empty?
      included = include_recursive(data, root)
    end
    included
  end

  def include_recursive(data, node)
    if node.value == data
      true
    elsif node.value > data && !node.left_link.nil?
      include_recursive(data, node.left_link)
    elsif node.value < data && !node.right_link.nil?
      include_recursive(data, node.right_link)
    else
      false
    end
  end

  def max
    tree_max = nil
    unless is_empty?
      node = root
      until node.right_link.nil?
        node = node.right_link
      end
      tree_max = node.value
    end
    tree_max
  end

  def min
    tree_max = nil
    unless is_empty?
      node = root
      until node.left_link.nil?
        node = node.left_link
      end
      tree_max = node.value
    end
    tree_max
  end

  def is_leaf?(node)
    node.left_link == nil && node.right_link == nil
  end

  def depth_of(data)
    depth = nil
    unless is_empty?
      depth = depth_recursive(data,root)-1
    end
    depth
  end

  def depth_recursive(data,node)
    if node.value == data
      depth = 1
    elsif node.value > data && !node.left_link.nil?
      depth = 1 + depth_recursive(data,node.left_link)
    elsif node.value < data && !node.right_link.nil?
      depth = 1 + depth_recursive(data,node.right_link)
    else
      depth = 0
    end
    depth
  end

  def sort
    sorted = nil
    unless is_empty?
      sorted = sort_recursive(root).flatten
    end
    sorted
  end

  def sort_recursive(node)
    if is_leaf?(node)
      sorted = [node.value]
    elsif node.left_link.nil?
      sorted = [node.value, sort_recursive(node.right_link)]
    elsif node.right_link.nil?
      sorted = [sort_recursive(node.left_link),node.value]
    else
      sorted = [sort_recursive(node.left_link),node.value,
      sort_recursive(node.right_link)]
    end
    sorted
  end

  def is_empty?
    !root
  end

  def load(filename)
    nums_in = reader.read_numbers(filename)
    unless nums_in.nil?
      nums_in.each {|num| insert(num)}
    end
  end
end

if __FILE__ == $0
  bst = BinarySearchTree.new
  binding.pry
end
