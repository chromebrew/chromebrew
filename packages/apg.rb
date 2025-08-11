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
    aarch64: '3f4ca5c19d08490f9302a8ff00499da1660e614dbe156167a80a95b85a631cad',
     armv7l: '3f4ca5c19d08490f9302a8ff00499da1660e614dbe156167a80a95b85a631cad',
       i686: '77b5ade38ac4e862d81625f7c987617cba4cff44d40a196f157c9ac4bc5f8762',
     x86_64: 'bfb1a844d4f3ef43bc37bc6f608b0fdb713e888abc11d91a5f1156b101675054'
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
