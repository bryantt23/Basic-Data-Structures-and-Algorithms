# https://github.com/sahilda/the_odin_project/blob/master/data-structures-and-algorithms/binary_search_tree.rb

class Node
  attr_accessor :left, :right, :parent, :value

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end

class Tree
  attr_accessor :root

  def build_tree(arr)
    @root = Node.new(arr[0])
    arr[1..-1].each do | value |
      set = nil
      cur_node = @root
      while not set
        if value > cur_node.value
          if cur_node.right == nil
            cur_node.right = Node.new(value, parent = cur_node)
            set = true
          else
            cur_node = cur_node.right
          end
        else
          if cur_node.left == nil 
            cur_node.left = Node.new(value, parent = cur_node)
            set = true
          else
            cur_node = cur_node.left
          end
        end
      end
    end
  end

  def get_sorted_tree(node = @root, result = [])
    get_sorted_tree(node.left, result) if node.left
    result << node.value
    get_sorted_tree(node.right, result) if node.right
    return result
  end

  def breadth_first_search(value)
    queue = [@root]
    visited = [@root]
    return @root if @root.value == value

    while queue.size > 0
      cur_node = queue.shift
      if cur_node.left && !visited.include?(cur_node.left)
        return cur_node.left if cur_node.left.value == value
        queue << cur_node.left
        visited << cur_node.left
      end
      if cur_node.right && !visited.include?(cur_node.right)
        return cur_node.right if cur_node.right.value == value
        queue << cur_node.right
        visited << cur_node.right
      end
    end
    nil
  end

  def depth_first_search(value)
    stack = [@root]
    visited = [@root]

    while stack.size > 0
      cur_node = stack[-1]
      return cur_node if cur_node.value == value
      if cur_node.left && !visited.include?(cur_node.left)
        return cur_node.left if cur_node.left.value == value
        stack << cur_node.left
        visited << cur_node.left
      elsif cur_node.right && !visited.include?(cur_node.right)
        return cur_node.right if cur_node.right.value == value
        stack << cur_node.right
        visited << cur_node.right
      else
        stack.pop
      end
    end
    nil
  end

  def dfs_rec(value, cur_node=@root)
    return cur_node if cur_node.value == value
    a = dfs_rec(value, cur_node.left) if cur_node.left
    return a if a
    b = dfs_rec(value, cur_node.right) if cur_node.right
    return b if b
    nil
  end

end

tree = Tree.new
tree.build_tree([4,1,0, -99, 23, 3, 5, 199, 8, 2])
puts tree.get_sorted_tree.join(", ")
puts tree.breadth_first_search(23)
puts tree.depth_first_search(23)
puts tree.dfs_rec(23)