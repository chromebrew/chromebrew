require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.8.0.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a0b67ee79a65bf28b68749f7982c87164f18373076405164fd0c5021fa72935',
     armv7l: '1a0b67ee79a65bf28b68749f7982c87164f18373076405164fd0c5021fa72935',
       i686: '4428ce3d922db137e351973b6bdbebfec589e069fb4664cbc39b9b34120483a3',
     x86_64: 'f22e9d2247135b3e1086d79d4abfe4f317f336e2126747d69368a4649040260f'
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
