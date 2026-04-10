require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.3.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37d4ac36b5a615e11bd1ab0b1b39958439f2d1a8167f5f9cbabe633545413c4c',
     armv7l: '37d4ac36b5a615e11bd1ab0b1b39958439f2d1a8167f5f9cbabe633545413c4c',
       i686: '53e909a71d40ced7044f1a906854ab2da4c3ce1be7dfbceae1f8875359e12197',
     x86_64: '895bfad9fd42d25054a3ebf6d4aeea41bfcb00a8759c4b4e815cb1d7af85ce28'
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
