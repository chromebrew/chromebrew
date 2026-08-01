require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd404f82cfecad3c514265c0bf9696a3cd185ed913150d14ca395bfd73d526154',
     armv7l: 'd404f82cfecad3c514265c0bf9696a3cd185ed913150d14ca395bfd73d526154',
       i686: '1714ed3fa3b186de971e7cb6850139a8327ce1d99149f663aabf5c5bf7684257',
     x86_64: '5f6d8b692e4fb0ec8554754cd5ef2a1645e7ea6e9c776256c72812f3552168b0'
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
