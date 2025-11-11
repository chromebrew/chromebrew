require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '25.8.3.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4668fb78a8d93315d7dde45616d7e1ee885ffa8a3105cdf26502ed721f260c49',
     armv7l: '4668fb78a8d93315d7dde45616d7e1ee885ffa8a3105cdf26502ed721f260c49',
       i686: 'c70e2022033ece666397460e651198b0ba116afbcc1e7c5d23eedbdb1299b101',
     x86_64: 'dbd5dfce530cbcb9ebd4da43691d7d70f3eb95c0e2f51912478be7179a86e76c'
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
