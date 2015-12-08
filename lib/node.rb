class Node
  attr_reader :value, :left_link,:right_link

  def initialize(data_in = [])
    @value = data_in
    @left_link = nil
    @right_link = nil
  end

  def change_right_link(link)
    @right_link = link
  end

  def change_left_link(link)
    @left_link = link
  end

end
