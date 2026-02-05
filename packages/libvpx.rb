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
    aarch64: '0e5e962ce9b8ca950d7b277cb52b95ea3e79e9d9f8dbb091b23eba828c88422d',
     armv7l: '0e5e962ce9b8ca950d7b277cb52b95ea3e79e9d9f8dbb091b23eba828c88422d',
     x86_64: '6c8c12bfee73d22a939bd0d6b294263de9e45f44e0a044b51349924b013a58c1'
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
