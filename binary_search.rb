# https://github.com/muzfuz/CodeLessons/blob/master/binary_search/binary_search.rb

#Constructor for the individual nodes

class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value, left_child=nil, right_child=nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
end

#Constructor for our Binary Tree, includes three search methods
class BinarySearchTree
  attr_accessor :array, :tree

  def initialize(array, tree=nil)
    @array = array
    @tree = tree

    build_tree(@array)
  end

  #Sorts the array using the merge_sort method, and builds the tree.
  def build_tree(array, left=0, right=array.length-1)
    return if left > right

    array = merge_sort(array)

    index_mid = left + (right-left) / 2 
    node = Node.new(array[index_mid])     
      
    node.left_child = build_tree(array, left, index_mid-1)      
    node.right_child = build_tree(array, index_mid+1, right)    

    @tree = node
    @tree
  end

  #ITERATIVE BREADTH FIRST SEARCH method
  def breadth_first_search(query)
    queue = []
    root = @tree.value

    return @tree if root == query #Returns the root item if the query matches

    left_child = @tree.left_child
    right_child = @tree.right_child

    queue << left_child if left_child != nil
    queue << right_child if right_child != nil
    
    loop do
      return nil if queue.empty?

      node = queue.shift
      return node if query == node.value

      queue << node.left_child if node.left_child != nil
      queue << node.right_child if node.right_child != nil
    end
  end

  #ITERATIVE DEPTH FIRST SEARCH METHOD
  def depth_first_search(query)
    stack = [@tree]

    loop do
      return nil if stack.empty?

      node = stack.pop
      return node if query == node.value

      stack.push node.left_child if node.left_child != nil
      stack.push node.right_child if node.right_child != nil
    end
  end
  
  #RECURSIVE DEPTH FIRST SEARCH METHOD
  def dfs_recursive(query, node=@tree)    
    return nil if node.nil?
    return node if query == node.value

    left_search = node.left_child != nil ? dfs_recursive(query, node.left_child) : nil
    return left_search if left_search != nil
    right_search = node.right_child != nil ? dfs_recursive(query, node.right_child) : nil
    return right_search if right_search != nil 
  end

  #MERGE SORT METHOD - Used for pre-sorting the array!
  def merge_sort(array)
    len = array.length
    return array if len == 1        #Base case set to an array size of 1
    
    array1 = array[0..(len/2)-1]      #Split the array in half
    array2 = array[len/2..-1]       #Array two gets the longer half if it's an odd length
    a1 = merge_sort(array1)         #Split array1 in half again recursively
    a2 = merge_sort(array2)         #Split array2 in half again recursively
    merge(a1, a2)             #Call the merge function on the split arrays        
  end

  #Helper method for Merge Sort
  def merge(array1, array2, merged_array=[])
    len_of_a1 = array1.length                 #Get length of arrays and compare to the array's index
    len_of_a2 = array2.length
    index1 = 0                          #Set the starting index for both arrays - always 0 since we are going left to right.
    index2 = 0

    while index1 < len_of_a1 and index2 < len_of_a2       #This loop continues until the end of one of the arrays is reached
      if array1[index1] < array2[index2]            #It compares the index values of both arrays, and appends the one that is lower in value
        merged_array << array1[index1]
        index1 += 1
      else
        merged_array << array2[index2]
        index2 += 1
      end
    end

    if index1 < len_of_a1                   #Appends any remaining values to the merged array
      merged_array += array1[index1..-1]            
    elsif index2 < len_of_a2
      merged_array += array2[index2..-1]
    end
    merged_array                        #Returns the merged array
  end

  #Use this function for debugging / displaying the tree.
  def display_tree()            
    list = []
    yield @tree.value
    left_child = @tree.left_child
    right_child = @tree.right_child

    list << left_child if left_child != nil
    list << right_child if right_child != nil

    loop do
      break if list.empty?
      node = list.shift
      yield node.value
      list << node.left_child if node.left_child != nil
      list << node.right_child if node.right_child != nil
    end
  end
end




###########
# TEST CODE
test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_array2 = [9,8,7,6,5,4,3,2,1,0]
test_array3 = ['a', 'c', 'd', 'u', 'n', 'z', 'uganda', 'cow']

#Assign instance of class
tree = BinarySearchTree.new(test_array)
#Use the display_tree function for debug purposes
tree.display_tree {|x| print "#{x} "}
print "\n"

#These should all return the appropriate 'Node' object
p tree.breadth_first_search(23)
p tree.depth_first_search(23)
p tree.dfs_recursive(23)


