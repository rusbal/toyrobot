#!/usr/bin/env ruby

require_relative './lib/robot'

puts "Robot by Raymond Usbal"

robot = Robot.new

begin
  loop do
    print "> "  # Show prompt
    input = gets&.chomp&.upcase
    break if input.nil? || input == 'QUIT' || input == 'EXIT'

    puts robot.call(input)
  end
rescue Interrupt
  puts "\nExiting..."
end
