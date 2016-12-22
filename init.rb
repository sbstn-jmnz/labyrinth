#!/usr/bin/env ruby
require_relative('lib/labyrinth')
puts
puts "Welcome to Labyrinth"
puts
puts "Please enter the information for the new labyrinth, please just enter integer numbers"
puts

print "Height: "
  height = gets.chomp.to_i

print "Width: "
  width = gets.chomp.to_i

print "Num of walls: "
  num_of_walls = gets.chomp.to_i

  lab = Labyrinth.new(top_left_corner: height, width: width, walls: num_of_walls)

puts
puts "This is the labyrinth generated for you:
     #{lab.description}"
puts
puts "your current position is: #{lab.current_pos} and the exit is at #{lab.exit}"
puts
puts "Would you like to get out (y/n)"
     answer = gets.chomp.to_s.downcase

def answer(answer, lab)
  case answer
    when "y"
      lab.solve
    when "n"
      puts "Good bye, you will be stuck for ever"
    else
      puts "Don't fool arround yes or no (y/n)"
      answer = gets.chomp.to_s.downcase
      answer(answer, lab)
  end
end

answer(answer, lab)
