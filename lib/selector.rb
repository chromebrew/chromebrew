# selector.rb: Prompt user to choose an option in a list of options
# See packages/hunspell.rb for example usage
require_relative 'color'
require_relative 'crewlog'
require 'io/console'

class Selector
  @@default_prompt = {
      heading: 'There are %{total_opts} provider(s) for this package: ',
    countdown: 'Default selected in %%2.2i second(s). Enter your choice [1 = %{default}]: '
  }

  def initialize(options, prompt = @@default_prompt, timeout = 10)
    @options = options
    # Set timeout to zero if a non-interactive console.
    # Check noninteractive usage with `setsid command`.
    @timeout = if !IO.console&.console_mode || IO.console&.winsize == [0, 0]
      # crewlog "IO.console&.console_mode is #{IO.console&.console_mode}"
      # crewlog "IO.console&.winsize is #{IO.console&.winsize}"
                 1
               else
                 timeout
               end

    # substitute expressions in the message ("%{variable}")
    @prompt = prompt.transform_values {|p| format(p, { total_opts: @options.size, default: @options[0][:value] }) }
  end

  def show_prompt
    # show_prompt(): Show prompt based on given options
    warn "#{@prompt[:heading]}\n\n"

    @options.each_with_index do |opt, i|
      $stderr.print "  #{i + 1}: #{opt[:value]}"
      $stderr.print " (#{opt[:description]})" if opt[:description]
      $stderr.print "\n"
    end

    warn "\n"

    # only show prompt when crew is running in an interactive terminal
    if $stdin.isatty
      begin
        fire_timer { Thread.kill(@io_read) }
        start_reading

        @io_read.join
      ensure
        Thread.kill(@countdown)
      end
    end

    if @io_read.nil? || @io_read[:input].to_s.chomp.empty?
      # empty input or timeout
      warn "Selected \"#{@options[0][:value]}\" by default.".yellow
      choice = 1
    elsif Integer(@io_read[:input], exception: false)&.between?(1, @options.size)
      # when input is valid (is an integer and in range)
      choice = @io_read[:input].to_i
    else
      # invalid input
      warn <<~EOT.yellow
        I don't understand "#{@io_read[:input]}". :(

        Selected "#{@options[0][:value]}" by default.
      EOT
      choice = 1
    end

    # return result
    return @options[choice - 1][:value]
  end

  private

  def fire_timer(&when_timeout)
    # fire_timer(): start a timer in separate thread
    @countdown = Thread.new do
      @timeout.downto(0).each do |remaining_time|
        # print current countdown
        $stderr.print "\r#{format(@prompt[:countdown], remaining_time)}"

        if remaining_time.zero?
          warn "\nTime expired.\n".yellow
          when_timeout.call
        else
          sleep 1
        end
      end
    end
  end

  def start_reading
    # start_reading(): read from terminal in separate thread
    @io_read = Thread.new do
      # discard any input in the input buffer
      $stdin.read_nonblock(1024)
    rescue IO::WaitReadable
    ensure
      Thread.current[:input] = $stdin.getc
    end
  end
end
