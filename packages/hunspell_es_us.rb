require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.5.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2838f6a13d2215818ea4c640060ce99988be6184e144c4becd425d2a00953d9c',
     armv7l: '2838f6a13d2215818ea4c640060ce99988be6184e144c4becd425d2a00953d9c',
       i686: 'c36847ad4bcce0d3bc12e2e3b998452d42a13e2ab61bcb0079716c16262ad8ae',
     x86_64: 'fc4d74afb6a95befadd9e82a74dd68b23b373c2e5db208760d3a21b1491fa635'
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
