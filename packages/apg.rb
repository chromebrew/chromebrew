require 'buildsystems/autotools'

class Apg < Autotools
  description 'APG (Automated Password Generator) is a toolset for random password generation.'
  homepage 'https://github.com/wilx/apg'
  version '2.3.0b-dcddc65'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/wilx/apg.git'
  git_hashtag 'dcddc65648f8b71ba8b9a9c1946034badb4ae7f3'
  # git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20eb0d25b5592a3fd50ed9bbc62e26bdc24aba53fb713441ef8ff80289ffe047',
     armv7l: '20eb0d25b5592a3fd50ed9bbc62e26bdc24aba53fb713441ef8ff80289ffe047',
       i686: '71eb0905e1b8d5c99c38387124d75e5340772c6bff3f2e1e63dbc862ea0f6e43',
     x86_64: 'f4c53b71baf1b4f0df6aec8bd4db95fe39f54652dc68c4d16b099d14e8d6cd82'
  })

  depends_on 'glibc' # R
  depends_on 'libxcrypt' # R

  def self.prebuild
    system 'autoreconf -fiv'
  end

  autotools_install_extras do
    FileUtils.install Dir['doc/man/*.1'], "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
    FileUtils.install Dir['doc/man/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
  end
end
