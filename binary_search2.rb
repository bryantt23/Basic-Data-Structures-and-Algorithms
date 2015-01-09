# https://github.com/sahilda/the_odin_project/blob/master/data-structures-and-algorithms/binary_search_tree.rb

class Node
#   instance variables
  attr_accessor :left, :right, :parent, :value

# Instance variables begin with @. 
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end

class Tree
  attr_accessor :root

  def build_tree(arr)
#   root is new node with array index 0
    @root = Node.new(arr[0])
        
#   for entire array do 
    arr[1..-1].each do | value |
      set = nil
      cur_node = @root

#   while not nil
      while not set
        
#   put bigger nodes to right, smaller to left
        if value > cur_node.value

#   if no node on right, make the new node here
          if cur_node.right == nil
            cur_node.right = Node.new(value, parent = cur_node)
            set = true
            
#   i think it's switching it? not sure
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

#   i think this just prints the tree, from left to right, appending to the result array for display
#   not sure how it works, but i think banas vid explains it 
  def get_sorted_tree(node = @root, result = [])
    get_sorted_tree(node.left, result) if node.left
    result << node.value
    get_sorted_tree(node.right, result) if node.right
    return result
  end

#   use queue
#   i think it is tracking which nodes have been visited
  def breadth_first_search(value)
    queue = [@root]
    visited = [@root]
    
#   return if found target
    return @root if @root.value == value

#   search while items in queue
    while queue.size > 0
      cur_node = queue.shift
      
#   i think if it hasn't been visited yet?
      if cur_node.left && !visited.include?(cur_node.left)
        
#   return if matches target value
        return cur_node.left if cur_node.left.value == value

#   otherwise add to queue & to visited array for comparison purposes
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


#   uses stack
  def depth_first_search(value)
    stack = [@root]
    visited = [@root]

    while stack.size > 0
      cur_node = stack[-1]
      
#   return if found match
      return cur_node if cur_node.value == value

#   i think if it hasn't been visited yet?
      if cur_node.left && !visited.include?(cur_node.left)

#   return if matches target value
        return cur_node.left if cur_node.left.value == value

#   otherwise add to stack & to visited array for comparison purposes
        stack << cur_node.left
        visited << cur_node.left

#   now it's doing same thing for the right side
      elsif cur_node.right && !visited.include?(cur_node.right)
        return cur_node.right if cur_node.right.value == value
        stack << cur_node.right
        visited << cur_node.right
      else
        
#   looks like this is the end of the loop
        stack.pop
      end
    end
    nil
  end

  def dfs_rec(value, cur_node=@root)
#   return if match
    return cur_node if cur_node.value == value
    
#   i think it is using recursion on the left nodes, parameters are value & left node, return a if there is an answer?
    a = dfs_rec(value, cur_node.left) if cur_node.left
    return a if a
    b = dfs_rec(value, cur_node.right) if cur_node.right
    return b if b
#     if neither a nor b, i guess it would return nil?
    nil
  end

end

tree = Tree.new
tree.build_tree([4,1,0, -99, 23, 3, 5, 199, 8, 2])
puts tree.get_sorted_tree.join(", ")
puts tree.breadth_first_search(23)
puts tree.depth_first_search(23)
puts tree.dfs_rec(23)