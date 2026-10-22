require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.2.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a55ff8074ce1259f52a6e3920ad12d687c8e8badc0c96fe746b07289ef1b1ac',
     armv7l: '7a55ff8074ce1259f52a6e3920ad12d687c8e8badc0c96fe746b07289ef1b1ac',
       i686: '96bf2cc6562bf0ede2a1000b84459255768e7abf149861234861bd51e44fe018',
     x86_64: '58099af5fc0f0168619d563ca3f30efa66397f84d10754a689a6d8de451c1e75'
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
