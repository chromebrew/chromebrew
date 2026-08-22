require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb0b8c26b1417d9fbf0d23fe5582aa9dfb79f4b6e812a3a32d400b5d48d708c8',
     armv7l: 'fb0b8c26b1417d9fbf0d23fe5582aa9dfb79f4b6e812a3a32d400b5d48d708c8',
       i686: '2cb519869da43aec98e5a68a6083a5b16021dfd6a917929f39da09665c633ffc',
     x86_64: 'ce3f4142ccfcbb237b225f4b38c0c0d12fb68aed33eb62eb36aabe92de2bf94e'
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
