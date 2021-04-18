require 'package'

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
    puts
    puts "Enter your preferred language:"
    puts "1 = American English"
    puts "2 = Français"
    puts "3 = Español"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
        when '1'
          depends_on 'hunspell_en_us'
          break
        when '2'
          depends_on 'hunspell_fr_fr'
          break
        when '3'
          depends_on 'hunspell_es_any'
          break
        when '0'
          abort
      end
    end
  end
end
