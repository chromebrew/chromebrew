require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.1.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'caec87e17a102d2cdc175342bf3c36bc6eb530d27f9c31379e8559d2baab8d8c',
     armv7l: 'caec87e17a102d2cdc175342bf3c36bc6eb530d27f9c31379e8559d2baab8d8c',
       i686: '7529d388c6f458f9544979d3655a1ffbae50343d6458f2084406bf98b9fceb75',
     x86_64: 'cfe0f4e1e178c5e05ede5743cb12efde9493a8c1d245bd573dd7d603a881884d'
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
