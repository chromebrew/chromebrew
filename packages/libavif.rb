require 'buildsystems/cmake'

class Libavif < CMake
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  version '1.1.0'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6632560338310f3909f141763e886af378a1671329d10f9bfd22310c596d50c',
     armv7l: 'a6632560338310f3909f141763e886af378a1671329d10f9bfd22310c596d50c',
     x86_64: '2f81bae4159dae77502f9c0c573e5b9a16156640a8c0eb23f93b5769c1c3b969'
  })

  depends_on 'dav1d' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libaom' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libwebp' # R
  depends_on 'libyuv' # R
  depends_on 'nasm' => :build
  depends_on 'pandoc' => :build
  depends_on 'pkgconf' => :build
  depends_on 'rav1e' # R
  depends_on 'svt_av1' # R
  depends_on 'zlib' # R

  gnome

  cmake_options '-DAVIF_BUILD_APPS=ON \
      -DAVIF_CODEC_AOM=ON \
      -DAVIF_CODEC_DAV1D=ON \
      -DAVIF_CODEC_RAV1E=ON \
      -DAVIF_CODEC_SVT=ON \
      -DAVIF_BUILD_GDK_PIXBUF=ON \
      -DAVIF_BUILD_MAN_PAGES=ON'
end
