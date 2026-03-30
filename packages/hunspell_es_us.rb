require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd39f20dfbadb413ad01879db07a034d349d1dc71c1c5b66c3208969e114dfff5',
     armv7l: 'd39f20dfbadb413ad01879db07a034d349d1dc71c1c5b66c3208969e114dfff5',
       i686: 'b15d5e701bd9a106d87cbec0ad51b0374c6ac628629c6566b1a151c318a7ff75',
     x86_64: '3b3ccd0d367dfa644bbacbab95df7c1e18c418e3afbd9298153682d5533a08b1'
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
