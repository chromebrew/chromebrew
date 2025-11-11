require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '25.8.3.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a90ff23957171cf1af1124701ca68c9f46cb7893fedeb568f90238b7d43d4078',
     armv7l: 'a90ff23957171cf1af1124701ca68c9f46cb7893fedeb568f90238b7d43d4078',
       i686: '9c3c01eadd76055d27f2c517cb06571445f370a519f0eeff28b17f116643bceb',
     x86_64: '984019dd5ea744163b7992162256e6e71a91ce1e7341c543d28c38e2f324e86d'
  })

  depends_on 'hunspell_base'

  def self.install
    FileUtils.install 'es/es_US.aff', "#{CREW_DEST_HOME}/Library/Spelling/es_US.aff", mode: 0o644
    FileUtils.install 'es/es_US.dic', "#{CREW_DEST_HOME}/Library/Spelling/es_US.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_es_us", <<~EOF
      # Configuración de hunspell
      export DICTIONARY=es_US
    EOF
  end
end
