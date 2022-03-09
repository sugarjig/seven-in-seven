# The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface.
# Let the initializer accept a nested structure of hashes. You should be able to specify a tree like this:
# {'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {}}, 'uncle' => {'child 3' => {}, 'child 4' => {}}}}

class Tree
  attr_accessor :children, :node_name

  def initialize(hash)
    @node_name = hash.keys[0]
    @children = []
    hash.values[0].each_pair { |key, value| @children.push(Tree.new({ key => value })) }
  end

  def visit_all(&block)
    visit(&block)
    children.each { |c| c.visit_all(&block) }
  end

  def visit(&block)
    block.call self
  end
end

family = { 'grandpa' => { 'dad' => { 'child 1' => {}, 'child 2' => {} }, 'uncle' => { 'child 3' => {}, 'child 4' => {} } } }
ruby_tree = Tree.new(family)

puts 'Visiting a node'
ruby_tree.visit { |node| puts node.node_name }
puts

puts 'visiting entire tree'
ruby_tree.visit_all { |node| puts node.node_name }
