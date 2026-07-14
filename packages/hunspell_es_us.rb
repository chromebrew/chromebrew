require 'package'

class Hunspell_es_us < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2576e21d9c2d7a83eb9a9806848eba43c8f5d2b2d6c19747b5e5e8cd508646c1',
     armv7l: '2576e21d9c2d7a83eb9a9806848eba43c8f5d2b2d6c19747b5e5e8cd508646c1',
       i686: 'c0bbce0edbb2754dea127c953c2a4cb8de1fc9cd4c6739f4a5d3ee5c216cafe8',
     x86_64: '47cbf489609c3717a7a55f451d70b1a2467164c0b34057ef6ef6addfcf4bd50b'
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
