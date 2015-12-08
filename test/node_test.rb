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
    assert_nil n.left_link
    assert_nil n.right_link
  end

  def test_can_change_the_right_link
    n = Node.new("Generic node")
    assert_nil n.left_link
    assert_nil n.right_link
    n.change_right_link("My Right Link")
    assert_nil n.left_link
    assert_equal "My Right Link", n.right_link
    assert_equal "Generic node", n.value
  end

  def test_can_change_the_left_link
    n = Node.new("Generic node")
    assert_nil n.left_link
    assert_nil n.right_link
    n.change_left_link("My Left Link")
    assert_equal "My Left Link", n.left_link
    assert_nil n.right_link
    assert_equal "Generic node", n.value
  end
end
