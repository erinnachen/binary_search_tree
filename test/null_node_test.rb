require 'minitest'
require 'null_node'

class NullNodeTest < Minitest::Test
  def test_is_nil
    n = NullNode.new()
    assert n.nil?
  end

  def test_doesnt_include_any_data
    n = NullNode.new()
    refute n.include?(0)
    refute n.include?("d")
  end

  def test_max_returns_nil
    n = NullNode.new()
    assert_nil n.max
  end

  def test_min_returns_nil
    n = NullNode.new()
    assert_nil n.min
  end

  def test_sort_returns_nil
    n = NullNode.new()
    assert_nil n.sort
  end

  def test_does_not_have_a_depth
    n = NullNode.new()
    assert_nil n.depth_of("d")
  end

  def test_returns_a_single_node_when_data_is_inserted
    n = NullNode.new()
    new_node, depth = n.insert("Hello")
    assert new_node.kind_of?(Node)
    assert_equal "Hello", new_node.value
    assert new_node.left_link.nil?
    assert new_node.right_link.nil?
    assert_equal 0, depth
  end

  def test_has_0_leaves
    n = NullNode.new()
    assert_equal 0, n.leaves
  end

  def test_has_0_height
    n = NullNode.new()
    assert_equal 0, n.height
  end

  def test_cannot_be_deleted
    n = NullNode.new()
    new_node, d = n.delete("any data")
    assert_equal n, new_node
    assert_nil d
  end

end
