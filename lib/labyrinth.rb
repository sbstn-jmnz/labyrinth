# Labyrinths are rectangulars and they have to have an exit
# allocated on one of its externals walls.
# They also have internals walls
require 'active_support'

class Labyrinth
  attr_accessor :exit
  attr_accessor :top_left_corner
  attr_accessor :width
  attr_accessor :walls
  attr_accessor :current_pos

  def initialize(options={})
    self.top_left_corner = options[:top_left_corner] || 5
    self.width = options[:width] || 5
    self.walls = generate_walls(options[:walls] || 5)
    self.exit = generate_exit
    #initial pos shouldn't be on top of external walls
    self.current_pos = { y: Random.new.rand(1..(@top_left_corner-1)), x: Random.new.rand(1..(@width-1)) }
  end

  def is_exit?(pos)
    return pos == @exit
  end


  def description
    "   It has #{self.top_left_corner.to_s} units of height,\n
     it has #{self.width} units of width and \n
     it has the following internal walls #{self.walls}"
  end

  def solve
    puts "you are out"
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
        { y: :top_left_corner, x: Random.rand(width) }
      when 4
        { y: Random.rand(top_left_corner), x: :width }
    end
  end

  def generate_walls(num_of_walls)
    num_of_walls.times.map{
      { y: Random.rand(top_left_corner), x: Random.rand(width)}
    }
  end

end
