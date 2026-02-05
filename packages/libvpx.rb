require 'buildsystems/autotools'

class Libvpx < Autotools
  description 'VP8/VP9 Codec SDK'
  homepage 'https://www.webmproject.org/code/'
  version '1.16.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://chromium.googlesource.com/webm/libvpx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c0e052c6610524e555c476cde5dfe522d5538f711788e010223eeb85a439992',
     armv7l: '2c0e052c6610524e555c476cde5dfe522d5538f711788e010223eeb85a439992',
     x86_64: '300c1866fed6b25968edf355b952e66ffb83627002bf5ce807365df3ccf2afbe'
  })

  depends_on 'ccache' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libyuv' => :build
  depends_on 'yasm' => :build

  autotools_configure_modifications [/--mandir=.*/, '']
  autotools_configure_options '--disable-debug-libs \
        --disable-docs \
        --disable-install-docs \
        --enable-ccache \
        --enable-libyuv \
        --enable-pic \
        --enable-runtime-cpu-detect \
        --enable-shared \
        --enable-vp8 \
        --enable-vp9 \
        --enable-vp9-highbitdepth'
end
