require 'package'
require_relative 'hunspell_en_us'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'https://hunspell.github.io/'
  version Hunspell_en_us.version
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'

  is_fake

  def self.preflight
    if ARGV.include?('install')
      options = [
        { value: 'hunspell_en_us',  description: 'American English' },
        { value: 'hunspell_fr_fr',  description: 'Français'         },
        { value: 'hunspell_es_any', description: 'Español'          }
      ]

      depends_on Selector.new(options).show_prompt
    end
  end
end
