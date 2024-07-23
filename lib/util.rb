require 'matrix'

class MutableMatrix < Matrix
  public :'[]='
end

# Returns the edit distance between strings string1 and string12
# https://en.wikipedia.org/wiki/Edit_distance
def edit_distance(string1, string2)
  # memo is the matrix for dynamic programming
  # memo[i, j] = the edit distance between the
  # prefixes of string1 and string2 of size i and j.
  memo = MutableMatrix.zero(string1.size + 1, string2.size + 1)
  string1.size.times { |i| memo[i + 1, 0] = i + 1 }
  string2.size.times { |j| memo[0, j + 1] = j + 1 }
  string1.size.times do |i|
    string2.size.times do |j|
      memo[i + 1, j + 1] = if string1[i] == string2[j]
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

  return memo[string1.size, string2.size]
end
