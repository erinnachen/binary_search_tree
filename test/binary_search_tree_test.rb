require 'minitest'
require 'binary_search_tree'

class BinarySearchTreeTest < Minitest::Test
  def test_bst_starts_out_empty
    bst = BinarySearchTree.new
    assert bst.root.nil?
  end

  def test_can_add_one_node
    bst = BinarySearchTree.new
    assert bst.root.nil?
    dm = bst.insert("m")
    refute bst.root.nil?
    assert_equal "m", bst.root.value
    assert_equal 0,dm
    assert bst.root.is_leaf?
  end

  def test_can_add_node_to_the_left
    bst = BinarySearchTree.new
    bst.insert("m")
    dc = bst.insert("c")
    refute bst.root.is_leaf?
    assert bst.root.right_link.nil?
    assert_equal "c", bst.root.left_link.value
    assert bst.root.left_link.is_leaf?
    assert_equal 1, dc
  end

  def test_can_add_node_to_the_right
    bst = BinarySearchTree.new
    bst.insert("m")
    dq = bst.insert("q")
    refute bst.root.is_leaf?
    assert bst.root.left_link.nil?
    assert_equal "q", bst.root.right_link.value
    assert bst.root.right_link.is_leaf?
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
    refute bst.root.is_leaf?
    assert bst.root.right_link.right_link.is_leaf?
  end

  def test_inserting_a_repeat_does_not_change_the_tree
    bst = BinarySearchTree.new
    dm = bst.insert("m")
    dm2 = bst.insert("m")
    assert_equal 0, dm
    assert_equal 0, dm2
    assert bst.root.is_leaf?
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

  def test_depth_returns_nil_for_element_not_in_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_nil bst.depth_of("a")
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
    assert_equal 0, num_in
  end

  def test_load_with_file_numbers_no_repeats
    bst = BinarySearchTree.new
    num_in = bst.load("test/support/simple_nums.txt")
    assert_equal 14, num_in
  end

  def test_load_with_file_numbers_with_repeats
    bst = BinarySearchTree.new
    num_in = bst.load("test/support/simple_nums_repeats.txt")
    assert_equal 14, num_in
  end

  def test_empty_tree_has_no_leaves
    bst = BinarySearchTree.new
    assert_equal 0, bst.leaves
  end

  def test_one_node_tree_has_one_leaf
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal 1, bst.leaves
  end

  def test_multi_node_tree_has_leaves
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    bst.insert("q")
    bst.insert("c")
    bst.insert("b")
    assert_equal 2, bst.leaves
  end

  def test_empty_tree_has_no_height
    bst = BinarySearchTree.new
    assert_equal 0, bst.height
  end

  def test_one_node_tree_has_height_of_1
    bst = BinarySearchTree.new
    bst.insert("m")
    assert_equal 1, bst.height
  end

  def test_right_loaded_tree
    bst = BinarySearchTree.new
    ["a","b","c","d","e"].each {|c| bst.insert(c)}
    assert_equal 5, bst.height
  end

  def test_left_loaded_tree
    bst = BinarySearchTree.new
    ["a","b","c","d","e"].reverse.each {|c| bst.insert(c)}
    assert_equal 5, bst.height
  end

  def test_multi_noded_tree_depth
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("c")
    bst.insert("a")
    bst.insert("q")
    bst.insert("t")
    bst.insert("z")
    assert_equal 4, bst.height
  end

  def test_cannot_delete_from_empty_tree
    bst = BinarySearchTree.new
    assert_nil bst.delete("m")
  end

  def test_delete_from_one_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    del = bst.delete("m")
    assert "m",del
    assert bst.root.nil?
  end

  def test_delete_not_in_one_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    del = bst.delete("a")
    assert_nil del
    assert bst.include?("m")
  end

  def test_delete_left_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("a")
    del = bst.delete("a")
    assert_equal "a", del
    assert bst.include?("m")
    refute bst.include?("a")
  end

  def test_delete_right_node_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("r")
    assert bst.root.left_link.nil?
    del = bst.delete("r")
    assert_equal "r", del
    assert bst.include?("m")
    refute bst.include?("r")
  end

  def test_delete_node_from_tree_with_both_left_and_right_on_tree
    bst = BinarySearchTree.new
    bst.insert("m")
    bst.insert("r")
    bst.insert("c")
    assert_equal "c",bst.root.left_link.value
    assert_equal "r",bst.root.right_link.value
    del = bst.delete("m")
    assert_equal "m", del
    refute bst.include?("m")
    assert bst.include?("r")
    assert bst.include?("c")
  end

  def test_delete_from_tree_more_than_two_levels
    bst = BinarySearchTree.new
    put_in_tree = "mcqkdlba".chars
    put_in_tree.each {|c| bst.insert(c)}
    assert_equal "a",bst.min
    assert_equal "q",bst.max
    del = bst.delete("c")
    assert_equal "abdklmq", bst.sort.join
    assert_equal "b", bst.root.left_link.value
  end

  def test_delete_from_random_tree
    bst = BinarySearchTree.new
    put_in_tree = (0..24).to_a.shuffle
    put_in_tree.each {|d| bst.insert(d)}
    assert_equal 0,bst.min
    assert_equal 24,bst.max
    d1 = bst.delete(12)
    d2 = bst.delete(20)
    put_in_tree.delete(12)
    put_in_tree.delete(20)
    assert_equal put_in_tree.sort, bst.sort
  end

  def test_delete_not_in_tree_from_random_tree
    bst = BinarySearchTree.new
    put_in_tree = (0..24).to_a.shuffle
    put_in_tree.each {|d| bst.insert(d)}
    del = bst.delete(33)
    assert_nil del
    assert_equal 0,bst.min
    assert_equal 24,bst.max
    assert_equal put_in_tree.sort, bst.sort
  end

end
