require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.0.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11658ab6eae8999e12d9730550d213dbb435413d9bb43a04cfb4babfe15f5f85',
     armv7l: '11658ab6eae8999e12d9730550d213dbb435413d9bb43a04cfb4babfe15f5f85',
       i686: '1202ab773022b16fc4bd76b3b4a606a0808edf718cf897287729e302016695fd',
     x86_64: '7fb6eb2225042e90db078415bfba6b50f004fe9ca65426ed5634865829b1440a'
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
