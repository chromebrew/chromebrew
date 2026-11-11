require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.3.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f51a19f42e5b5209bdde5e33948ab203a47e0363047304cc35dc6779cfa604b',
     armv7l: '1f51a19f42e5b5209bdde5e33948ab203a47e0363047304cc35dc6779cfa604b',
       i686: '927917b5eb597e256e7560cc6d4bd1b14e1dbc3bbea3841671f05cdce3470f44',
     x86_64: 'c34cc21f746d68924d44bfb1e757daabfa842b7bc898ec17a94353eda96631a5'
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
