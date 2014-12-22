#!/usr/bin/env ruby

# N-Queens puzzle solver - version 4.2
# USAGE: ruby n_queens.rb <NQUEENS>

def check_along_dimension candidate
  candidate.transpose.map do |lst|
    lst.uniq.length == lst.length
  end.all?
end

def rotate_coordinates candidate_coordinates
  candidate_coordinates.map do |c|
    [c.reduce(:-), c.reduce(:+)]
  end
end

def to_coordinates candidate
  candidate.each_with_index.map { |x,y| [x,y+1] }
end

def check_solution candidate
  check_along_dimension  rotate_coordinates  to_coordinates  candidate
end

def solve boardsize
  (1..boardsize).to_a.permutation.select do |candidate|
    check_solution(candidate).tap do |ans|
      print_solution(candidate) if ans
    end
  end
end

# That's all. Now for some pretty printing

module SubAt; def sub_at(n,i); self.tap { |s| s[n] = i }; end; end
def baseline(boardsize); (". " * boardsize).extend SubAt; end
def board_line(qpos, boardsize); baseline(boardsize).sub_at((qpos-1)*2, "x"); end

def print_solution solution
  coordinates = to_coordinates  solution
  puts "\n-> " + coordinates.to_s
  cols = (coordinates.sort { |a, b| a.first <=> b.first }).transpose.last
  cols.each { |c| puts board_line(c, coordinates.length) }
end

# Main execution

if __FILE__==$0
  raise ArgumentError, "USAGE: ruby n_queens.rb <NQUEENS>" unless ARGV.size==1
  nqueens = ARGV.first.to_i

  puts "\nSolving n-queens problem of size #{nqueens}:"
  sols = solve(nqueens)
  puts "\nTotal: #{sols.size} solutions found."
end
