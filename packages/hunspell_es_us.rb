require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.3.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffb1300cc250189b6ea2938a1cad15a7e367f670ced8bf4579961b2d1fc29bed',
     armv7l: 'ffb1300cc250189b6ea2938a1cad15a7e367f670ced8bf4579961b2d1fc29bed',
       i686: '7ca93f7877e316793c1feccee2eee14c8c24a8ef025362c1dbe9b9140ae6bb68',
     x86_64: 'bf7280f53ebc2a6683f5ec2d6db5f76cbd5e11297c0d34fbe1460f5921ff4724'
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
