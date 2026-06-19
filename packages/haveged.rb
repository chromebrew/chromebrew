require 'buildsystems/autotools'

class Haveged < Autotools
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.23'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75259359f5c0e602394376f25b06db15b2ed3c605ea7ea256522f398debdae4d',
     armv7l: '75259359f5c0e602394376f25b06db15b2ed3c605ea7ea256522f398debdae4d',
       i686: '9d58e2f93d8e127a05de0ce8ce423b997171095f7522a707f3aa0d704576290d',
     x86_64: '6b6928656b656366240ab29b5a730af40f6391d48e9c5116933f3af0d9fbeb03'
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
