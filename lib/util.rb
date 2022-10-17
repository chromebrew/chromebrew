require 'matrix'

class MutableMatrix < Matrix
  public :'[]='
end

# Returns the edit distance between strings a and b
# https://en.wikipedia.org/wiki/Edit_distance
def edit_distance(a, b)
  # memo is the matrix for dynamic programming
  # memo[i, j] = the edit distance between the
  # prefixes of a and b of size i and j.
  memo = MutableMatrix.zero(a.size + 1, b.size + 1)
  a.size.times { |i| memo[i + 1, 0] = i + 1 }
  b.size.times { |j| memo[0, j + 1] = j + 1 }
  a.size.times do |i|
    b.size.times do |j|
      memo[i + 1, j + 1] = if a[i] == b[j]
                             memo[i, j]
                           else
                             [
                               memo[i + 1, j],
                               memo[i, j + 1],
                               memo[i, j]
                             ].min + 1
                           end
    end
  end

  return memo[a.size, b.size]
end
