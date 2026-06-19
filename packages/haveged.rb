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
    aarch64: 'c914ecd22b9716e8f5056d336186a1c7db87a5688e4ae5c25e6adf2c071c5664',
     armv7l: 'c914ecd22b9716e8f5056d336186a1c7db87a5688e4ae5c25e6adf2c071c5664',
       i686: '7cbc6449d1d334c9bda3578da5c5aa0617440773b3dda00b0d2f7eb9c49079f4',
     x86_64: 'acfe380d00637ac91d64e8d32c5c0491ed142e5ac1028b6e83255b1ad37c3284'
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
