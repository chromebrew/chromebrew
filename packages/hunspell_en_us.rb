require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.8.2.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c90470022d2e80f4ed80e64b0f549e9521ed2608b80be8e737d034d1bb76e0c',
     armv7l: '9c90470022d2e80f4ed80e64b0f549e9521ed2608b80be8e737d034d1bb76e0c',
       i686: '346d4c66ee3d3712c6a33e5800b7db21a7812f401b179cda8b3a2f1cc72dc09d',
     x86_64: '71a2322b4799f32a794020806b691ae0e954f68a5e3b817e15054b67174fa00a'
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
