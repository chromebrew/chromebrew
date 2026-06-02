require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.4.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5132978aae9bea35366336a7788b999987781d3413881d6296d3c2a5a44d1958',
     armv7l: '5132978aae9bea35366336a7788b999987781d3413881d6296d3c2a5a44d1958',
       i686: '4481731d19d75650245fc1314b8365eed385342256fc0c78399f87029fb1f497',
     x86_64: '5b896fe55f3d3e67cc01baa9b84230581003e03e956bb18462476e39b2698d8f'
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
