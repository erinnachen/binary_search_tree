require 'minitest'
require 'node'

class NodeTest < Minitest::Test
  def test_has_a_default_value_empty_array
    n = Node.new()
    assert_equal [], n.value
  end

  def test_can_have_a_nondefault_value
    n = Node.new("My data")
    assert_equal "My data", n.value
  end

  def test_starts_with_links_to_nil
    n = Node.new("Generic node")
    assert n.left_link.nil?
    assert n.right_link.nil?
  end

  def test_can_change_left_link
    n = Node.new("Generic node")
    n.change_left_link("new left link")
    assert_equal "new left link", n.left_link
    assert n.right_link.nil?
  end

  def test_can_change_right_link
    n = Node.new("Generic node")
    n.change_right_link("new right link")
    assert_equal "new right link", n.right_link
    assert n.left_link.nil?
  end

  
end
