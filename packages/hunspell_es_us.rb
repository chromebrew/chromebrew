require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.1.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd295f77ca99dcb728e4f921d9e5afcce5b68da4b4c74d2067d9166eb7a719241',
     armv7l: 'd295f77ca99dcb728e4f921d9e5afcce5b68da4b4c74d2067d9166eb7a719241',
       i686: '2fedf1d26195ecd99fd8c36b720e2f58cadefcca3e1f858e8b6252506505e052',
     x86_64: '5b3f3d7780f3a9f08f4103cc050f83b4e8af9665a1fbfc8b44b48b3e3a2fb36a'
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
