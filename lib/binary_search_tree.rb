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
    @root = NullNode.new
    @reader = FileReader.new
  end

  def insert(data)
    @root, depth = root.insert(data)
    depth
  end

  def max
    root.max
  end

  def min
    root.min
  end

  def depth_of(data)
    root.depth_of(data)
  end

  def sort
    root.sort
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
