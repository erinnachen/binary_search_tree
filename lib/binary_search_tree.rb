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

  def include?(data)
    root.include?(data)
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

  def leaves
    root.leaves
  end

  def load(filename)
    nums_in = reader.read_numbers(filename)
    inserted = 0
    unless nums_in.nil?
      nums_in = nums_in.uniq
      nums_in.each do |num|
        insert(num)
        inserted +=1
      end
    end
    inserted
  end

  def height
    root.height
  end

  def delete(data)
    @root, data = root.delete(data)
    data
  end
end

if __FILE__ == $0
  # bst = BinarySearchTree.new
  # put_in_tree = "mcqkdlba".chars
  # put_in_tree.each {|c| bst.insert(c)}
  # bst.delete("c")
  # bst #=>
end
