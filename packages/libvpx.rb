require 'buildsystems/autotools'

class Libvpx < Autotools
  description 'VP8/VP9 Codec SDK'
  homepage 'https://www.webmproject.org/code/'
  version '1.17.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://chromium.googlesource.com/webm/libvpx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c2a40ec88b98a65dbf994db7d0a49b3981df6539a2f2158b2ce6eaee5947361',
     armv7l: '8c2a40ec88b98a65dbf994db7d0a49b3981df6539a2f2158b2ce6eaee5947361',
     x86_64: '792708c2f5ab4bd2183841ad1e6d6dc35af3486ff8fdd24d13453c4629f4548d'
  })

  depends_on 'ccache' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
