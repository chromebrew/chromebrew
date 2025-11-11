require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '25.8.3.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bde230cb123cd04ce1e36d51cee6b3225d61c1c7b8d3962c397a31cca68f155',
     armv7l: '8bde230cb123cd04ce1e36d51cee6b3225d61c1c7b8d3962c397a31cca68f155',
       i686: 'a886e2a0a037b7f9363414c786ff6124c48d1377eba391b9a686f85c78158287',
     x86_64: '50c560f73838494afce43cbf3d60d48a72a8499493ec78bbba48d27c0ec75b8d'
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
