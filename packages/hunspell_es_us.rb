require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.4.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbe0676e9e2aa439cf36cb76fab841c35fc3f9adac2f77594b73fabb3785186c',
     armv7l: 'dbe0676e9e2aa439cf36cb76fab841c35fc3f9adac2f77594b73fabb3785186c',
       i686: '98470ba4fb6b7faacc7fdf1f1c1483d1f51fc5a4f1426171e2eace152c6eb8ec',
     x86_64: '13ca47d78224ba8f71782de4706cd76e6a2ce6a77b5939f8da57223cf5e328b6'
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
