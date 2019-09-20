require "minitest/autorun"

class List

  def initialize
    @head = nil
  end

  def get(id)
    if @head == nil then
      return nil
    else
      current_node = @head
      id.times do
        current_node = current_node.next
      end
      return current_node.value
    end
  end

  def add(value)
    if @head == nil then
      @head = Node.new(value)
    else
      current = @head
      until current.next == nil do
        current = current.next
      end
      current.next = Node.new(value)
    end
  end

  def add_at(id, value)
    if @head == nil then
      @head = Node.new(value)
    elsif id == 0
      new_head = Node.new(value)
      new_head.next = @head
      @head = new_head
    else
      current_node = @head
      (id - 1).times do
        current_node = current_node.next
      end
      node_to_insert = Node.new(value)
      tail = current_node.next
      node_to_insert.next = tail
      current_node.next = node_to_insert
    end
  end

  def delete_at(id)
    return if id > self.size - 1
    if id == 0 then
      @head = @head.next
    else
      current_node = @head
      (id - 1).times do
        current_node = current_node.next
      end
      current_node.next = current_node.next.next
    end
  end


  def size
    return 0 if @head == nil
    size = 1
    current = @head
    until current.next == nil do
      size += 1
      current = current.next
    end
    return size
  end

  def get_all
    array = Array.new
    return "" if @head == nil
    current = @head
    until current == nil do
      array << current.value
      current = current.next
    end
    return array
  end

end

class Node
  def initialize(value)
    @value = value
    @next = nil
  end

  attr_accessor :value, :next
end

class Test < Minitest::Test
  def setup
    @list = List.new
    @list.add(1)
    @list.add(2)
  end

  def test_get_all
    assert_equal [1,2], @list.get_all
  end

  def test_add
    @list.add(3)
    assert_equal [1, 2, 3], @list.get_all
  end

  def test_add_at
    @list.add_at(1, 1.5)
    assert_equal [1, 1.5, 2], @list.get_all
  end

  def test_get
    assert_equal 1, @list.get(0)
  end

  def test_delete_at
    @list.delete_at(0)
    assert_equal [2], @list.get_all
  end

  def test_size
    assert_equal 2, @list.size
  end

end

