require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.2.1.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c37e0558fe917da8174be6b7533ecbe0df762b6b990c64565d53dfdd9f2ed36',
     armv7l: '9c37e0558fe917da8174be6b7533ecbe0df762b6b990c64565d53dfdd9f2ed36',
       i686: '90f1870ad3a94595a0ab2d9f0bed6957ee04ce324c0be2b6fc9a4310800b2e2b',
     x86_64: 'afd9998435228f40fedce9b5a98f165ef12df4a79a88cbbc6d5e5c8bf51bacda'
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
