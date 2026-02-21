require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.2.1.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2593c979c60340033b09c2f3cab3ded48d975aa3a426b563186ffa1dfea909bc',
     armv7l: '2593c979c60340033b09c2f3cab3ded48d975aa3a426b563186ffa1dfea909bc',
       i686: '04891daa36d08b42446a0cef9e81e8624388306a76f8228c8b620a96b2bdb588',
     x86_64: 'db74ce95f5fb3d7fd7b58dc6c3f2e943188b410fc8403a1fde7cf4b8e76f5d2e'
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
