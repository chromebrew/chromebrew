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
    aarch64: 'b2643e04f963c3175c60cd0dc2946ff20085487d9bbc909375941a7cc194932c',
     armv7l: 'b2643e04f963c3175c60cd0dc2946ff20085487d9bbc909375941a7cc194932c',
       i686: 'daf7fb92149ac851d85d5125c74c0b767f7268f26c7fce274ef03ab2c3cbda25',
     x86_64: '5273d6d665fefe7fca09131609644a6fc10681ee7b259ec3bce87ce982ebd358'
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
