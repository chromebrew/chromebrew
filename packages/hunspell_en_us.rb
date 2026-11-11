require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.8.3.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0faf266db3b02433e75aff6e53030792e853990fd97fc84b832e3d3c9438f247',
     armv7l: '0faf266db3b02433e75aff6e53030792e853990fd97fc84b832e3d3c9438f247',
       i686: 'e47e29a7425a0e6bebb91de02f87d39babc00aae9241a524aeeebafe6ea1b2ad',
     x86_64: 'cc633d7841bb582d9c985f63a9d4e31448d57164db87a2bb7b2e008d6ddb9683'
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
