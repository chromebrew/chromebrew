require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.3.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e24455adcec09f1f87d42c97c1b464cf3d98bc64e18d1160caf35208d46f4a0',
     armv7l: '4e24455adcec09f1f87d42c97c1b464cf3d98bc64e18d1160caf35208d46f4a0',
       i686: 'fdea14cf85307d4b3d3c2688bd4bc10244cfcf619a638c2c1f5e7e6abe76bf14',
     x86_64: 'a4157d5077c9d3c49aa6cce061b466f77d23e942dbc0801eeda175fc3df46ad6'
  })

  depends_on 'hunspell_base'

  def self.install
    FileUtils.install 'fr_FR/fr.aff', "#{CREW_DEST_HOME}/Library/Spelling/fr_FR.aff", mode: 0o644
    FileUtils.install 'fr_FR/fr.dic', "#{CREW_DEST_HOME}/Library/Spelling/fr_FR.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_fr_fr", <<~EOF
      # Configuración de hunspell
      export DICTIONARY=fr_FR
    EOF
  end
end
