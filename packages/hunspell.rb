require 'package'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'https://hunspell.github.io'
  version '1.7.0'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'

  is_fake

  if ARGV.include?('install') # fix when 'install' isn't in ARGV[0] (like `crew -k install`)
    @timeout = 10

    puts <<~EOT

      1 = American English (default)
      2 = Français
      3 = Español
      0 = Cancel

    EOT

    if $stdin.isatty # check if stdin is a terminal
      @stdin_thread = Thread.new do
        @user_input = $stdin.getc
        @user_input = 1 if @user_input == "\n"

        Thread.kill(@countdown_thread) # stop countdown when user input
      end

      @countdown_thread = Thread.new do
        (0..@timeout).each do |i|
          remaining_time = @timeout - i
          print "\rDefault selected in #{remaining_time} second(s).  Enter your preferred language [1 = American English]: "

          if remaining_time.zero?
            Thread.kill(@stdin_thread) # stop reading from terminal if timeout
          else
            sleep 1
          end
        end
      end

      @stdin_thread.join
      @countdown_thread.join
    end

    case @user_input
    when '0'
      abort "\nCancelled.".lightred
    when '1'
      depends_on 'hunspell_en_us'
    when '2'
      depends_on 'hunspell_fr_fr'
    when '3'
      depends_on 'hunspell_es_any'
    else
      warn "\nSelected 'American English' by default.".yellow
      depends_on 'hunspell_en_us'
    end
  end
end
