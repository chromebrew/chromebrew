require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.2.2.1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a12d77bc849661d9f62767172b2cc770acd4114f206641b6469420d54f3cd997',
     armv7l: 'a12d77bc849661d9f62767172b2cc770acd4114f206641b6469420d54f3cd997',
       i686: 'c32e8e90f9b9595f06a3038b74580f9a10282a0e58db544a47394ce5a0ea5333',
     x86_64: '26c93a98e2eb82c09b13abca33c97f3c96b87b2ca7b4bee9d51c8aa8d7b2855f'
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
