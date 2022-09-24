require 'package'
require 'timeout'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  is_fake

  if ARGV[0] == 'install'
    begin
      @timeout = 10
      @user_input = Timeout.timeout(@timeout) do
        puts
        puts 'Enter your preferred language:'
        puts "(The default, American English, will be selected in #{@timeout} seconds if there is no input.)"
        puts '1 = American English'
        puts '2 = Français'
        puts '3 = Español'
        puts '0 = Cancel'
        $stdin.getc.chomp.to_i
      end
    rescue Timeout::Error
      @user_input = 1
    end
    depends_on 'hunspell_en_us' if @user_input == 1
    depends_on 'hunspell_fr_fr' if @user_input == 2
    depends_on 'hunspell_es_any' if @user_input == 3
    abort if @user_input.zero?
  end
end
