require 'buildsystems/autotools'

class Haveged < Autotools
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.26'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21f02fcaf9f14eac1b062a0980ada034c1e400b447c15faa5ac3589b48fcb7ea',
     armv7l: '21f02fcaf9f14eac1b062a0980ada034c1e400b447c15faa5ac3589b48fcb7ea',
       i686: '6fbd946ca7e8cc4765255626b1a2537a2b9b7b89e8c4744d66246209cbda22b6',
     x86_64: 'e769f38b953524e3f6ccc8be79cf455418bf68007a6a3cee0b3ecd1a614a8fbf'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options ' \
    --disable-daemon \
    --enable-nistest \
    --enable-enttest \
    --enable-olt \
    --enable-threads'

  def self.prebuild
    system 'autoreconf -fiv'
  end

  run_tests
end
