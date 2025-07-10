#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/robot'

puts 'Robot by Raymond Usbal'

robot = Robot.new

begin
  loop do
    print '> ' # Show prompt
    input = gets&.chomp&.upcase
    break if input.nil? || input == 'QUIT' || input == 'EXIT'

    result = robot.call(input)
    puts result if result
  end
rescue Interrupt
  puts "\nExiting..."
end
