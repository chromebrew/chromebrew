require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a4ec1d0bf09937597c985477631bcf8735f8ae2e2d284c294cc3b2b803531dc',
     armv7l: '5a4ec1d0bf09937597c985477631bcf8735f8ae2e2d284c294cc3b2b803531dc',
       i686: '4b81f2fadd1ffcb262d511c5282d25f2916cecf4e95faa8102735fbb1af051b8',
     x86_64: 'ce898d687597adb53d168d2b676bb75bca102b7d6fec400877736574da811c02'
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
