require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9adc594b096dc35774bee6c73f27222c9c74034c5ef33a24ae3c01b06d3c97f1',
     armv7l: '9adc594b096dc35774bee6c73f27222c9c74034c5ef33a24ae3c01b06d3c97f1',
       i686: '0bba0003050081f5e5458697c5923ac8a6123c9fe20dc21b0af5747fab26880f',
     x86_64: 'fdbbb03ffa9cf25ac125df9803253c69b3e796db33f6d534dd865f8ca9ba8383'
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
