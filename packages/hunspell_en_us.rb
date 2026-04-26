require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.2.3.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfdcbec6357f5386fed782861ef6e6c30b56a64971973a9fc7c2a54c96b2200f',
     armv7l: 'bfdcbec6357f5386fed782861ef6e6c30b56a64971973a9fc7c2a54c96b2200f',
       i686: '55eebf9b5aa032a5c6b5142f6a0a2df4abe3941488baa9338dd5043775e17d71',
     x86_64: '8075d41975ee545115a3325a8347bb40ad6f60a320667b3b86a4d35d8806658b'
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
