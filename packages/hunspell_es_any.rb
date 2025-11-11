require 'package'

class Hunspell_es_any < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '6.4'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version.gsub('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7eba48f03f26a5ab1006c6fcfd4ec8f3e28f3888379646496d00e9ff994e4e6',
     armv7l: 'b7eba48f03f26a5ab1006c6fcfd4ec8f3e28f3888379646496d00e9ff994e4e6',
       i686: '9d44c92b70aae024d44ae0e917499b10dfbeae4c87628dd59654b12635259746',
     x86_64: '9ef8c2ffcfa382381f17b334e08dea664fb3dfd97cd129a43839e14ba39847c1'
  })

  depends_on 'hunspell_base'
  ignore_updater

  def self.install
    FileUtils.install 'es/es_ANY.aff', "#{CREW_DEST_HOME}/Library/Spelling/es_ANY.aff", mode: 0o644
    FileUtils.install 'es/es_ANY.dic', "#{CREW_DEST_HOME}/Library/Spelling/es_ANY.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_es_any", <<~EOF
      # Configuración de hunspell
      export DICTIONARY=es_ANY
    EOF
  end
end
