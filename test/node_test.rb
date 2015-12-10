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

  def test_new_node_is_a_leaf
    n = Node.new("Generic node")
    assert n.is_leaf?
    n.change_left_link("No more leaf...")
    refute n.is_leaf?
  end

  def test_two_connected_nodes_only_has_right_branch
    n = Node.new("Generic node")
    n.change_right_link(Node.new("This is my right branch"))
    refute n.is_leaf?
    assert n.only_has_right_branch?

  end

  def test_two_connected_nodes_only_has_left_branch
    n = Node.new("Generic node")
    n.change_left_link(Node.new("This is my left branch"))
    refute n.is_leaf?
    assert n.only_has_left_branch?
  end

  def test_insert_one_node_into_another_right
    n = Node.new("m")
    n.insert("q")
    assert n.only_has_right_branch?
    assert_equal "q", n.right_link.value
    assert n.right_link.is_leaf?
  end

  def test_insert_one_node_into_another_left
    n = Node.new("m")
    n.insert("c")
    assert n.only_has_left_branch?
    assert_equal "c", n.left_link.value
    assert n.left_link.is_leaf?
  end

  def test_insert_one_node_into_both_sides
    n = Node.new("m")
    dc = n.insert("c")
    dq = n.insert("q")
    assert_equal "c", n.left_link.value
    assert_equal "q", n.right_link.value
    assert_equal 1, dc[1]
    assert_equal 1, dq[1]
  end

  def test_insert_multi_levels_deep
    n = Node.new("m")
    dc = n.insert("c")
    n.insert("q")
    n.insert("z")
    dd = n.insert("d")
    da =n.insert("a")
    assert_equal 2, dd[1]
  end

  def test_insert_repeat_single_node
    n = Node.new("m")
    dm = n.insert("m")
    assert_equal 0, dm[1]
    assert n.is_leaf?
  end

  def test_insert_repeat_multi_levels
    n = Node.new("m")
    dc = n.insert("c")
    n.insert("q")
    n.insert("z")
    dz = n.insert("z")
    assert_equal 2, dz[1]
    assert n.right_link.right_link.right_link.nil?
  end

  def test_include_single_node_includes_itself
    n = Node.new("m")
    assert n.include?("m")
  end

  def test_include_single_node_doesnt_include_others
    n = Node.new("m")
    assert n.include?("m")
    refute n.include?("g")
  end

  def test_include_for_multi_level_nodes
    n = Node.new("m")
    dc = n.insert("c")
    n.insert("q")
    n.insert("z")
    n.insert("d")
    n.insert("a")
    assert n.include?("z")
    assert n.include?("d")
  end

  def test_max_returns_value_for_single_node
    n = Node.new("m")
    assert_equal "m", n.max
  end

  def test_min_returns_value_for_single_node
    n = Node.new("m")
    assert_equal "m", n.min
  end

  def test_max_returns_correct_value_for_right_branch_two_elements
    n = Node.new("m")
    n.insert("z")
    assert_equal "z", n.max
  end

  def test_max_returns_correct_value_for_left_branch_two_elements
    n = Node.new("m")
    n.insert("a")
    assert_equal "m", n.max
  end

  def test_min_returns_correct_value_for_right_branch_two_elements
    n = Node.new("m")
    n.insert("z")
    assert_equal "z", n.max
  end

  def test_min_returns_correct_value_for_left_branch_two_elements
    n = Node.new("m")
    n.insert("a")
    assert_equal "m", n.max
  end

  def test_max_returns_correct_value_for_node_with_two_branches
    n = Node.new(3)
    put_in = (0..6).to_a
    put_in.each {|d| n.insert(d)}
    assert_equal 6, n.max

  end

  def test_min_returns_correct_value_for_node_with_two_branches
    n = Node.new(3)
    put_in = (0..6).to_a
    put_in.each {|d| n.insert(d)}
    assert_equal 0, n.min
  end

  def test_depth_of_single_node_is_0
    n = Node.new("m")
    assert_equal 0, n.depth_of("m")
  end

  def test_depth_of_two_linked_nodes_is_1_right_branch
    n = Node.new("m")
    n.insert("q")
    assert_equal 0, n.depth_of("m")
    assert_equal 1, n.depth_of("q")
  end

  def test_depth_of_two_linked_nodes_is_1_left_branch
    n = Node.new("m")
    n.insert("c")
    assert_equal 0, n.depth_of("m")
    assert_equal 1, n.depth_of("c")
  end

  def test_depth_of_not_present_element_is_nil
    n = Node.new("m")
    assert_nil n.depth_of("c")
  end

  def test_depth_of_multiple_branches_greater_than_depth_1
    n = Node.new(3)
    put_in = (0..6).to_a
    put_in.each {|d| n.insert(d)}
    assert_equal 0, n.depth_of(3)
    assert_equal 3, n.depth_of(6)
    assert_equal 1, n.depth_of(0)
  end

  def test_depth_of_multi_linked_node_not_present_element
    n = Node.new("m")
    put_in= "cqkdlba".chars
    put_in.each {|d| n.insert(d)}
    assert_nil n.depth_of("z")
  end

  def test_sort_single_node
    n = Node.new("m")
    assert_equal ["m"],n.sort
  end

  def test_sort_two_nodes_right_branch
    n = Node.new("m")
    n.insert("q")
    assert_equal ["m", "q"], n.sort
  end

  def test_sort_two_nodes_left_branch
    n = Node.new("m")
    n.insert("c")
    assert_equal ["c", "m"], n.sort
  end

  def test_sort_multi_nodes
    n = Node.new(3)
    put_in = (0..25).to_a.shuffle
    put_in.each {|d| n.insert(d)}
    assert_equal put_in.sort, n.sort
  end

  def test_single_node_has_one_leaf
    n = Node.new("m")
    assert_equal 1,n.leaves
  end

  def test_two_linked_nodes_have_one_leaf_right_branch
    n = Node.new("m")
    n.insert("q")
    assert_equal 1,n.leaves
  end

  def test_two_linked_nodes_have_one_leaf_left_branch
    n = Node.new("m")
    n.insert("c")
    assert_equal 1,n.leaves
  end

  def test_one_node_with_both_branches_has_two_leaves
    n = Node.new("m")
    n.insert("c")
    n.insert("q")
    assert_equal 2,n.leaves
  end

  def test_leaves_of_multi_linked_node_with_both_branches
    n = Node.new("m")
    put_in= "cqkdlba".chars
    put_in.each {|d| n.insert(d)}
    assert_equal 4, n.leaves
  end

  def test_single_node_has_height_of_1
    n = Node.new("m")
    assert_equal 1, n.height
  end

  def test_two_nodes_height_right_branch
    n = Node.new("m")
    n.insert("q")
    assert_equal 2, n.height
  end

  def test_two_nodes_height_left_branch
    n = Node.new("m")
    n.insert("c")
    assert_equal 2, n.height
  end

  def test_two_nodes_height_both_branches
    n = Node.new("m")
    n.insert("c")
    n.insert("q")
    assert_equal 2, n.height
  end

  def test_multi_nodes_height_branches_of_different_lengths_right_branch
    n = Node.new("m")
    n.insert("c")
    n.insert("q")
    n.insert("z")
    assert_equal 3, n.height
  end

  def test_multi_nodes_height_branches_of_different_lengths_left_branch
    n = Node.new("m")
    n.insert("c")
    n.insert("q")
    n.insert("a")
    assert_equal 3, n.height
  end

  def test_delete_from_one_node
    n = Node.new("m")
    n, dm = n.delete("m")
    assert n.nil?
    assert n.kind_of?(NullNode)
    assert_equal "m",dm
  end

  def test_delete_not_in_one_node
    n = Node.new("m")
    n, dm = n.delete("c")
    assert n.include?("m")
    assert n.is_leaf?
    assert_nil dm
  end

  def test_delete_left_node_in_two_linked_nodes_left
    n = Node.new("m")
    n.insert("a")
    n, del = n.delete("a")
    assert_equal "a", del
    assert n.include?("m")
    refute n.include?("a")
  end

  def test_delete_right_node_in_two_linked_nodes_right
    n = Node.new("m")
    n.insert("q")
    n, del = n.delete("q")
    assert_equal "q", del
    assert n.include?("m")
    refute n.include?("q")
  end
  def test_delete_node_from_node_with_two_branches
    n = Node.new("m")
    n.insert("r")
    n.insert("c")
    assert_equal "c",n.left_link.value
    assert_equal "r",n.right_link.value
    n, del = n.delete("m")
    assert_equal "m", del
    refute n.include?("m")
    assert n.include?("r")
    assert n.include?("c")
  end

  def test_delete_from_tree_more_than_two_levels
    n = Node.new("m")
    put_in = "cqkdlba".chars
    put_in.each {|c| n.insert(c)}
    assert_equal "a",n.min
    assert_equal "q",n.max
    n2, del = n.delete("c")
    assert_equal "abdklmq", n2.sort.join
    assert_equal "b", n.left_link.value
  end
  #
  def test_delete_from_random_linked_nodes
    n = Node.new(12)
    put_in = (0..24).to_a.shuffle
    put_in.each {|d| n.insert(d)}
    assert_equal 0, n.min
    assert_equal 24,n.max
    n2, d1 = n.delete(12)
    n3, d2 = n2.delete(20)
    put_in.delete(12)
    put_in.delete(20)
    assert_equal put_in.sort, n3.sort

  end

  def test_delete_not_in_tree_from_random_linked_nodes
    n = Node.new(12)
    put_in = (0..24).to_a.shuffle
    put_in.each {|d| n.insert(d)}
    n2, del = n.delete(33)
    assert_nil del
    assert_equal 0,n.min
    assert_equal 24,n.max
    assert_equal put_in.sort, n.sort
  end


end
