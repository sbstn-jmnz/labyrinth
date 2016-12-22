# Labyrinths are rectangulars and they have to have an exit
# allocated on one of its externals walls.
# They also have internals walls
require 'byebug'

class Labyrinth
  attr_accessor :top_left_corner, :width, :exit,
                :walls, :current_pos, :visited_nodes,
                :adjacents, :traveled_path, :node_queue

  #initial pos shouldn't be on top of external walls
  def initialize(options={})
    self.top_left_corner = options[:top_left_corner] || 5
    self.width = options[:width] || 5
    self.exit = generate_exit
    self.walls = generate_walls(options[:walls] || 5)
    self.current_pos = { y: Random.new.rand(1..(@top_left_corner-1)), x: Random.new.rand(1..(@width-1)) }
    self.visited_nodes = []
    self.adjacents = []
    self.traveled_path = []
    self.node_queue = []
  end

  def description
    "It has #{self.top_left_corner.to_s} units of height,\n
     it has #{self.width} units of width and \n
     it has the following internal walls #{self.walls}"
  end

  def is_exit?(pos); pos == @exit ; end

  def up(pos);    { y: pos[:y] + 1, x: pos[:x] } ; end
  def down(pos);  { y: pos[:y] - 1, x: pos[:x] } ; end
  def left(pos);  { y: pos[:y], x: pos[:x] - 1 } ; end
  def right(pos); { y: pos[:y], x: pos[:x] + 1 } ; end

  def permited_move?(pos,move)
    #check if the move dosen't crash with a bound or a wall
    case move
      when 'up'
        !@walls.include?({ y: pos[:y] + 1, x: pos[:x] }) && (pos[:y] + 1) < @top_left_corner
      when 'down'
        !@walls.include?({ y: pos[:y] - 1, x: pos[:x] }) && (pos[:y] -1)  > 0
      when 'left'
        !@walls.include?({ y: pos[:y], x: pos[:x] - 1 }) && (pos[:x] - 1) > 0
      when 'right'
        !@walls.include?({ y: pos[:y], x: pos[:x] + 1 }) && (pos[:x] + 1) < @width
    end
  end

  def find_adjacents(pos)
    @adjacents = []
    @adjacents.push up(pos) if permited_move?(pos,'up')
    @adjacents.push down(pos) if permited_move?(pos,'down')
    @adjacents.push left(pos) if permited_move?(pos,'left')
    @adjacents.push right(pos) if permited_move?(pos,'right')
    return adjacents
  end

  def exit_arround?(pos)
    [:up,:down,:left,:right].each do |dir|
       return if is_exit?(send(dir,pos))
    end
    false
  end

  def solve
    visited_nodes.push(current_pos)
    node_queue.push(current_pos)
    traveled_path.push(current_pos)
    while node_queue.length > 0
      find_adjacents(node_queue.shift).each do |p|
        unless visited_nodes.include?(p)
            visited_nodes.push(p)
            node_queue.push(p)
            traveled_path.push(p)
          if exit_arround?(p)
            puts traveled_path
          end
        end
      end
    end
  end

protected
  def generate_exit
    #exit should be placed on the external walls
    external_wall = 1 + Random.rand(4)
    case external_wall
      when 1
        { y: 0, x: Random.rand(width) }
      when 2
        { y: Random.rand(top_left_corner), x: 0 }
      when 3
        { y: top_left_corner, x: Random.rand(width) }
      when 4
        { y: Random.rand(top_left_corner), x: width }
    end
  end

#For simplification walls are just dots
  def generate_walls(num_of_walls)
    num_of_walls.times.map do
      { y: Random.rand(top_left_corner), x: Random.rand(width)}
    end
  end

end
