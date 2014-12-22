#!/usr/bin/env ruby

# N-Queens puzzle solver - version 4.2
# USAGE: ruby n_queens.rb <NQUEENS>

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
