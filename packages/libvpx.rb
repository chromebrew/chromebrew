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
    aarch64: '00e81914069c08483411380bdb4b992e63e172504d3f6257664c4d0114952cf8',
     armv7l: '00e81914069c08483411380bdb4b992e63e172504d3f6257664c4d0114952cf8',
     x86_64: 'e38a5ea3a9eb39cf7d4d55b6c1c0b2691bbf014276bd1c6dc3b4ff6fec6e00b0'
  })

  depends_on 'ccache' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libyuv' => :build
  depends_on 'yasm' => :build

  autotools_configure_modifications [/--mandir=.*/, '']
  autotools_configure_options '--disable-debug-libs \
        --disable-docs \
        --disable-examples \
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
