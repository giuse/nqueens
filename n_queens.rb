#!/usr/bin/env ruby

# N-Queens puzzle solver - version 4.1

# This work is licensed under the Creative Commons Attribution-NonCommercial-
# ShareAlike 3.0 Unported License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative
# Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
# Copyright 2014 Giuseppe Cuccu - all rights reserved

# This puzzle can be seen as enforcing two conditions over 2D coordinates:
# a. There should be no orthogonal crossing (no two coords sharing row/column)
# b. There should be no diagonal crossing (no two coords on same diagonal

# I satisfy the first by building candidate solutions from permutations of rows
# and columns, to grant their uniqueness. Moreover I sort the candidates by the
# rows, in order to reduce the permutation space (duplicate solutions changing
# the order of the queens in the solution listing). I then verify the second
# condition by rotating the reference system by PI/4 radians, and then check no
# repetitions in the two new list of coordinates.

# This method is extremely efficient in both CPU and RAM usage. My laptop finds
# all solutions (including mirrored) for 9 queens in less than 6 seconds, with a
# ram occupation of few KB since each solution is evaluated (and eventually
# discarded) upon construction.

def check_along_dimension candidate
  candidate.transpose.map do |lst| 
    lst.uniq.length == lst.length
  end.all?
end

def rotate_coordinates candidate_coordinates
  candidate_coordinates.map { |c| [c.reduce(:-), c.reduce(:+)]  }
end

def to_coordinates candidate
  candidate.each_with_index.map { |x,y| [x,y+1] }
end

def check_solution candidate
  check_along_dimension rotate_coordinates to_coordinates candidate
end

def solve boardsize
  (1..boardsize).to_a.permutation.select do |candidate|
      check_solution(candidate) && print_solution(candidate)
    end
end

# Some pretty printing

def baseline(boardsize); ". " * boardsize; end
class String; def sub_at(n,i); self[n] = i; self; end; end
def board_line(qpos, boardsize); baseline(boardsize).sub_at((qpos-1)*2, "x"); end

def print_solution solution
  coordinates = to_coordinates solution
  puts "\n-> " + coordinates.to_s
  cols = (coordinates.sort { |a, b| a.first <=> b.first }).transpose.last
  cols.each { |c| puts board_line c, coordinates.length }
  true # trick to simplify `#solve`
end

# MAIN execution

raise ArgumentError, "USAGE: ruby n_queens.rb <NQUEENS>" unless ARGV.size==1

puts "\nSolutions found:"
sols = solve(ARGV.first.to_i)
puts "\nTotal: #{sols.size} solutions found."
