require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.2.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '038fffdef75ed4369c988ddd5bb9c3e457b06727707c2e8f2ba7ef55c6d9c40d',
     armv7l: '038fffdef75ed4369c988ddd5bb9c3e457b06727707c2e8f2ba7ef55c6d9c40d',
       i686: 'e566947762ac647ac7cdb2c672bdb631ba4dadb6a5a08d0083b73558075667d7',
     x86_64: 'e5535e0a6cdd23407b12e6c3b0076243b06fc0faa9fd223a0c7025aa7dd65074'
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
