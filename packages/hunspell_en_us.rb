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
    aarch64: '27bfe8f57365e1533694b34a3a806ec75e80f5c31c69fe0101cbeade43c37ed9',
     armv7l: '27bfe8f57365e1533694b34a3a806ec75e80f5c31c69fe0101cbeade43c37ed9',
       i686: '18fafe0ec102686b2daa6f7dcab7ce9f3f9bb3fdb555997cb0d514f8db32f3ce',
     x86_64: '82bcbf000f52382bb87be974e9db9d9a1cf38b05eb64f3d20e60ca54228b4dc9'
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
