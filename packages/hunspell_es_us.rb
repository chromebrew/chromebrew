require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.0.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab8fdc7896b589b5faafd185b4a0bf3283d7f1de3d38bac9b818fdedefddc247',
     armv7l: 'ab8fdc7896b589b5faafd185b4a0bf3283d7f1de3d38bac9b818fdedefddc247',
       i686: '586ed8b86a3fb614c0371eaaedf7c79a50174ca7a7d06efac05f226b2d3f3019',
     x86_64: '1e409e0cbebcada53807115a03139573fe81a0d810904838a01123d2a49f3d6b'
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
