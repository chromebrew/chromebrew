require 'buildsystems/cmake'

class Libavif < CMake
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  version '1.0.4'
  license 'BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '201cd0bb7b76838dee1c00c007df295cda6da1b4882391b38d36341495e59861',
     armv7l: '201cd0bb7b76838dee1c00c007df295cda6da1b4882391b38d36341495e59861',
     x86_64: 'f171c132ed9429f7338b78b92df4fdb134855f78346bf883c03419d7a8d76057'
  })

  depends_on 'dav1d' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libaom' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libwebp' # R
  depends_on 'libyuv' # R
  depends_on 'nasm' => :build
  depends_on 'pandoc' => :build
  depends_on 'pkgconf' => :build
  depends_on 'rav1e' # R
  depends_on 'svt_av1' # R
  depends_on 'zlibpkg' # R

  gnome

  cmake_options '-DAVIF_BUILD_APPS=ON \
      -DAVIF_CODEC_AOM=ON \
      -DAVIF_CODEC_DAV1D=ON \
      -DAVIF_CODEC_RAV1E=ON \
      -DAVIF_CODEC_SVT=ON \
      -DAVIF_BUILD_GDK_PIXBUF=ON \
      -DAVIF_BUILD_MAN_PAGES=ON'
end
