require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a6f5c7261a83cd19c63f63ea05e596ee4f808afc26ce17e467b0b536084c19e',
     armv7l: '4a6f5c7261a83cd19c63f63ea05e596ee4f808afc26ce17e467b0b536084c19e',
       i686: '88cf465498eca1d2eedcafda1330d9a6b5f94f720c68ac019a627d0340744f4c',
     x86_64: '914e7a70cc86a3ac6eed462f285b30f902aa3531a850b81ea4e3f3b13011ccf8'
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
