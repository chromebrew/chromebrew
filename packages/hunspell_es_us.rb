require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f017b55c57144460745b1b2e88044c4a90b811c3d57125c3d772d3a5c2e854c1',
     armv7l: 'f017b55c57144460745b1b2e88044c4a90b811c3d57125c3d772d3a5c2e854c1',
       i686: 'd9f005b5562e45f942a9f2a2a0a6d6771f88eb34a4c9be152f63a213e2ab0579',
     x86_64: '186896593c71c3d0e82c47010700de0ad406611daf146a4de5143a83417c2507'
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
