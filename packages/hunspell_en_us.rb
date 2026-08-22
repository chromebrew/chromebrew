require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c2dbfcff2269c5c9a0f7d62a68d8f933a9a55567c90c757e1bc8f100ac44136',
     armv7l: '3c2dbfcff2269c5c9a0f7d62a68d8f933a9a55567c90c757e1bc8f100ac44136',
       i686: '0765e81367dd01cccaa9ae2e1377faaa4f01c1b87570a2e20fa44fc3d94396aa',
     x86_64: '59b0e882ecf2e30763674b307900b86aa7721634f032a77b26cadc460d596c62'
  })

  depends_on 'hunspell_base'

  def self.install
    FileUtils.install 'en/en_US.aff', "#{CREW_DEST_HOME}/Library/Spelling/en_US.aff", mode: 0o644
    FileUtils.install 'en/en_US.dic', "#{CREW_DEST_HOME}/Library/Spelling/en_US.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_en_us", <<~EOF
      # American English hunspell configuration
      export DICTIONARY=en_US
    EOF
  end
end
