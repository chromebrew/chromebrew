require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e7906ec4d16ae989adbc4fc54ea91a3602c5de46a3d47af51ac40d179de829c',
     armv7l: '5e7906ec4d16ae989adbc4fc54ea91a3602c5de46a3d47af51ac40d179de829c',
       i686: 'c135e318c4be1fdc8de885262c1650d324018f2419f199b6853f35ac20dbaa54',
     x86_64: '44918f6ca8008dfde51d61bda7f3656d9929b10987c9140be356f1bc5f856a14'
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
