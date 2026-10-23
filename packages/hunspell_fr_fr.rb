require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5b6ae4c3e6e2eb9c5d2333bc48e5f2e7794f9e43301a199c37fe27a9c288aa7',
     armv7l: 'b5b6ae4c3e6e2eb9c5d2333bc48e5f2e7794f9e43301a199c37fe27a9c288aa7',
       i686: '7512d70a2f5b2196b83cece09751dcc226eaf01f6fe896bf7afae7290c19319f',
     x86_64: '42b482814e1ecaf207ad8ff1dfbdae2aee9e05292d2d7000b90ee3564e8c66ff'
  })

  depends_on 'hunspell_base'

  def self.install
    FileUtils.install 'fr_FR/dictionaries/fr.aff', "#{CREW_DEST_HOME}/Library/Spelling/fr_FR.aff", mode: 0o644
    FileUtils.install 'fr_FR/dictionaries/fr.dic', "#{CREW_DEST_HOME}/Library/Spelling/fr_FR.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_fr_fr", <<~EOF
      # Configuración de hunspell
      export DICTIONARY=fr_FR
    EOF
  end
end
