require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.2.0.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f4dd73619d94bca609bc3724626e1dc154250421dfd9dbc9c4b698dd75a9361',
     armv7l: '9f4dd73619d94bca609bc3724626e1dc154250421dfd9dbc9c4b698dd75a9361',
       i686: '7ad208e9402e01f4ac84e6cb5deabf4fdf5aa676e4cbcd8be47107b275452004',
     x86_64: 'a4acf95f7815077bf2a77cc4436e9ac47665819750642872f8e6166faa15e442'
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
