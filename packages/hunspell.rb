require 'package'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  is_fake

  if ARGV[0] == 'install'
    puts
    puts "Enter your preferred language:"
    puts "1 = English (US)"
    puts "2 = French (FR)"
    puts "3 = Spanish (ANY)"
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
