# lib/misc_functions.rb
# Generic implementations of various functions/algorithms that are not crew-specific.
require 'matrix'
require_relative 'color'

class MiscFunctions
  def self.human_size(bytes)
    kilobyte = 1024.0
    megabyte = kilobyte * kilobyte
    gigabyte = megabyte * kilobyte
    if bytes < kilobyte
      units = 'B'
      size = bytes
    end
    if (bytes >= kilobyte) && (bytes < megabyte)
      units = 'KB'
      size = bytes / kilobyte
    end
    if (bytes >= megabyte) && (bytes < gigabyte)
      units = 'MB'
      size = bytes / megabyte
    end
    if bytes >= gigabyte
      units = 'GB'
      size = bytes / gigabyte
    end
    return format('%.2f %s', size, units)
  end

  # Returns the edit distance between strings string1 and string12
  # https://en.wikipedia.org/wiki/Edit_distance
  def self.edit_distance(string1, string2)
    # memo is the matrix for dynamic programming
    # memo[i, j] = the edit distance between the
    # prefixes of string1 and string2 of size i and j.
    memo = Matrix.zero(string1.size + 1, string2.size + 1)
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

  def self.time_difference(start_time = nil, end_time = nil)
    return 'ERROR' if start_time.nil? || end_time.nil?

    time_elapsed = end_time.to_i - start_time.to_i
    time_hours = time_elapsed / 3600
    time_minutes = time_elapsed / 60 % 60
    time_seconds = time_elapsed % 60
    time_hour_string = if time_hours.zero?
                         ''
                       else
                         "#{time_hours} hr#{time_hours > 1 ? 's, ' : ', '}"
                       end
    time_minutes_string = if time_minutes.zero?
                            time_hour_string.empty? ? '' : "#{time_minutes} min, "
                          else
                            "#{time_minutes} min, "
                          end
    time_seconds_string = "#{time_seconds} second#{'s' unless time_seconds == 1}"
    return time_hour_string + time_minutes_string + time_seconds_string
  end

  def self.check_free_disk_space(bytes = 0)
    formatted_size = human_size(bytes)
    free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
    abort "\nNot enough free disk space.  You need at least #{formatted_size} to install.\n".lightred if free_space < bytes
  end
end
