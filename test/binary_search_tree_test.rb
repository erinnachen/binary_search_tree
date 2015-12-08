require 'minitest'
require 'binary_search_tree'

class BinarySearchTreeTest < Minitest::Test
  def test_bst_starts_out_empty
    bst = BinarySearchTree.new
    assert_nil bst.root
  end

  def test_can_add_one_node
    bst = BinarySearchTree.new
    assert_nil bst.root
    dm = bst.insert("m")
    refute_nil bst.root
    assert_equal "m", bst.root.value
    assert bst.is_leaf?(bst.root)
    assert_equal 0,dm
  end

  def test_can_add_node_to_the_left
    bst = BinarySearchTree.new
    bst.insert("m")
    dc = bst.insert("c")
    refute bst.is_leaf?(bst.root)
    assert_nil bst.root.right_link
    assert_equal "c", bst.root.left_link.value
    assert bst.is_leaf?(bst.root.left_link)
    assert_equal 1, dc
  end

  def test_can_add_node_to_the_right
    bst = BinarySearchTree.new
    bst.insert("m")
    dq = bst.insert("q")
    refute bst.is_leaf?(bst.root)
    assert_nil bst.root.left_link
    assert_equal "q", bst.root.right_link.value
    assert bst.is_leaf?(bst.root.right_link)
    assert_equal 1, dq
  end

  def test_can_add_nodes_to_both_sides_without_depth_change
    bst = BinarySearchTree.new
    dm = bst.insert("m")
    dc = bst.insert("c")
    dq = bst.insert("q")
    assert_equal 0, dm
    assert_equal 1, dc
    assert_equal 1, dq
  end

  def test_can_insert_two_levels_deep
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("q")
    dz = bst.insert("z")
    assert_equal 2, dz
    refute bst.is_leaf?(bst.root)
    assert bst.is_leaf?(bst.root.right_link.right_link)
  end

  def test_inserting_a_repeat_does_not_change_the_tree
    bst = BinarySearchTree.new
    dm = bst.insert("m")
    dm2 = bst.insert("m")
    assert_equal 0, dm
    assert_equal 0, dm2
    assert bst.is_leaf?(bst.root)
    bst.insert("q")
    bst.insert("z")
    dz2 = bst.insert("z")
    assert_equal 2, dz2
  end

  def test_empty_tree_does_not_include_anything
    bst = BinarySearchTree.new
    refute bst.include?("")
    refute bst.include?("a")
  end

  def test_include_for_one_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    assert bst.include?("m")
    refute bst.include?("c")
  end

  def test_include_for_multi_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("c")
    bst.insert("q")
    bst.insert("a")
    assert bst.include?("a")
    assert bst.include?("q")
    refute bst.include?("n")
  end

  def test_empty_tree_does_not_have_a_max
    bst = BinarySearchTree.new
    assert_nil bst.max
  end

  def test_empty_tree_does_not_have_a_min
    bst = BinarySearchTree.new
    assert_nil bst.min
  end

  def test_single_node_is_the_max
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal "m", bst.max
  end

  def test_single_node_is_the_min
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal "m", bst.min
  end

  def test_two_node_tree_has_the_correct_max
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    assert_equal "m", bst.max

    bst2 = BinarySearchTree.new
    bst2.insert("m")
    bst2.insert("x")
    assert_equal "x", bst2.max

  end

  def test_two_node_tree_has_the_correct_min
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    assert_equal "a", bst.min

    bst2 = BinarySearchTree.new
    bst2.insert("m")
    bst2.insert("x")
    assert_equal "m", bst2.min
  end

  def test_multi_node_tree_for_max
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    bst.insert("q")
    bst.insert("c")
    assert_equal "q",bst.max
  end

  def test_multi_node_tree_for_min
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    bst.insert("q")
    bst.insert("c")
    assert_equal "a",bst.min
  end

  def test_empty_tree_has_no_depth
    bst = BinarySearchTree.new
    assert_nil bst.depth_of("m")
  end

  def test_depth_for_one_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal 0, bst.depth_of("m")
  end

  def test_depth_for_multi_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    bst.insert("q")
    bst.insert("c")
    assert_equal 0, bst.depth_of("m")
    assert_equal 1, bst.depth_of("a")
    assert_equal 1, bst.depth_of("q")
    assert_equal 2, bst.depth_of("c")
  end

  def test_sort_returns_nil_for_empty_tree
    bst = BinarySearchTree.new
    assert_nil bst.sort
  end

  def test_sort_returns_single_element_array_for_one_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal ["m"], bst.sort
  end

  def test_sort_returns_array_for_two_node_tree_right
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("q")
    assert_equal ["m","q"], bst.sort
  end

  def test_sort_returns_array_for_two_node_tree_left
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    assert_equal ["a","m"], bst.sort
  end

  def test_sort_returns_array_for_multi_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    bst.insert("q")
    bst.insert("c")
    bst.insert("b")
    assert_equal ["a","b","c","m","q"], bst.sort
  end

  def test_load_with_empty_file
    bst = BinarySearchTree.new
    num_in = bst.load("test/support/empty.txt")
    assert_nil num_in
  end

  def test_load_with_file_numbers_no_repeats
    bst = BinarySearchTree.new
    num_in = bst.load("test/support/simple_nums.txt")
    refute_nil num_in
    assert_equal [-31,-3,1,2,3,4,5,6,7,8,9,10,35,87],
    bst.sort
  end

  def test_load_with_file_numbers_with_repeats
    bst = BinarySearchTree.new
    num_in = bst.load("test/support/simple_nums_repeats.txt")
    assert_equal [-34,-17,-3,0,1,2,3,4,5,6,7,8,9,10],
    bst.sort
  end
end
