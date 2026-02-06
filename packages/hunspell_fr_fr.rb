require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.1.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ffc20cf1079f0a7dd5ad1529f972c3e9fd021e613fec72d08a551685d927422',
     armv7l: '5ffc20cf1079f0a7dd5ad1529f972c3e9fd021e613fec72d08a551685d927422',
       i686: '661f5a54154297e3e5c1695f2fed116ee8555ded7f3ea0151a5eb72de72a5ce6',
     x86_64: '36f26febd5b3d238882ba6f1dbc50957c6200adaa74ed4a5b3ed46f8aabc2daf'
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
