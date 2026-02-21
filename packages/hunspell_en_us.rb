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
    aarch64: '20a947cb8b1379b08734566e6ecdb0db1228ab66903d243d435a99cbfbc341be',
     armv7l: '20a947cb8b1379b08734566e6ecdb0db1228ab66903d243d435a99cbfbc341be',
       i686: '1286a699fd71adbfac3334f2e085739f8dfba617946b3bfe55bcbdebaa96babc',
     x86_64: '6ec07753f2e12641bdff8a516faeac54e590db9adb7e103ace0f7e542b0cec3a'
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
