require 'io/console'
require_relative 'color'
require_relative 'convert_size'

class ProgressBar
  class InvalidSizeError < StandardError; end

  attr_accessor :progress_bar_showing

  def initialize(total_size)
    # character used to fill the progress bar, one of the box-drawing character in unicode
    @bar_char = "\u2501"

    # color scheme of progress bar, can be changed
    # see color.rb for more available colors
    @bar_front_color = %i[lightcyan no_bold]
    @bar_bg_color    = %i[gray no_bold]

    # all info blocks with space taken
    @info_before_bar = { downloaded_size_in_str: 20 }
    @info_after_bar = { percentage_in_str: 4, elapsed_time_in_str: 8 }

    @percentage = @downloaded = 0
    @total_size = total_size.to_f

    @total_size_in_str = human_size(@total_size)

    trap('WINCH') do
      # reset width settings after terminal resized
      # get terminal size, calculate the width of progress bar based on it
      @terminal_h, @terminal_w = IO.console&.console_mode ? IO.console&.winsize : [25, 80]
      @bar_width = @terminal_w -
                   @info_before_bar.merge(@info_after_bar).values.sum - # space that all info blocks takes
                   (@info_before_bar.merge(@info_after_bar).length * 2) # space for separator (whitespaces) between each info
      if @bar_width.negative?
        puts "IO.console&.winsize reports #{IO.console&.winsize}"
        puts "@terminal_h is #{@terminal_h}"
        puts "@terminal_w is #{@terminal_w}"
        puts "@bar_width is #{@bar_width}"
        puts "@info_before_bar.merge(@info_after_bar).values.sum is #{@info_before_bar.merge(@info_after_bar).values.sum}"
        puts "(@info_before_bar.merge(@info_after_bar).length * 2) is #{@info_before_bar.merge(@info_after_bar).length * 2}"
      end
    end

    Process.kill('WINCH', 0) # trigger the trap above
  end

  def set_downloaded_size(downloaded_size, invalid_size_error: true)
    if downloaded_size > @total_size
      # when the given downloaded size/total size is invalid (given downloaded size > given total size),
      # set all info to unknown (except downloaded size)
      @elapsed_time = @total_size = 0
      @elapsed_time_in_str = '--:--:--'

      @percentage = 100
      @percentage_in_str = '---'

      @total_size_in_str = ''
      @downloaded_size_in_str = human_size(downloaded_size)

      # raise error unless #{invalid_size_error} is set to false
      if invalid_size_error
        raise InvalidSizeError, 'The given downloaded size is larger than the total size'
      else
        return false
      end
    end

    if @start_time
      @elapsed_time = (Time.now - @start_time).to_i
    else
      # record start time, used for calculating elapsed time
      @start_time = Time.now
      @elapsed_time = 0
    end

    @elapsed_time_in_str = Time.at(@elapsed_time).utc.strftime('%H:%M:%S')

    # calculate progress percentage, round to nearest 0.1
    @percentage = ((downloaded_size / @total_size) * 100).round(1)
    @percentage_in_str = "#{@percentage.to_i}%"

    # {downloaded size}/{total size}
    @downloaded_size_in_str = "#{human_size(downloaded_size)}/#{@total_size_in_str}"
  end

  def show
    @progress_bar_showing = true

    return Thread.new do
      print "\e[?25l" # hide cursor to prevent cursor flickering

      while @progress_bar_showing
        sleep 0.15 # update progress bar after each 0.15 seconds

        completed_length = (@bar_width * (@percentage / 100)).to_i
        uncompleted_length = @bar_width - completed_length
        if completed_length.negative? || uncompleted_length.negative?
          puts "@bar_width is #{@bar_width}"
          puts "@percentage is #{@percentage}"
          puts "completed_length: #{completed_length}"
          puts "uncompleted_length: #{uncompleted_length}"
        end

        # print info and progress bar
        @info_before_bar.each_pair do |var_name, width|
          printf '%*.*s  ', width, width, instance_variable_get("@#{var_name}")
        end

        # print progress bar with color code
        print (@bar_char * completed_length).send(*@bar_front_color),
              (@bar_char * uncompleted_length).send(*@bar_bg_color)

        @info_after_bar.each_pair do |var_name, width|
          printf '  %*.*s', width, width, instance_variable_get("@#{var_name}")
        end

        # stop when 100%
        @percentage >= 100 ? break : print("\r")
      end
    ensure
      print "\e[2K\r\e[?25h" # clear line and restore cursor mode
    end
  end
end
