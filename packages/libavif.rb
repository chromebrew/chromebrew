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
    aarch64: '0133f0f922637cd9f96c4d3e70273968fdc648dc3f71d3e60345900677baf16a',
     armv7l: '0133f0f922637cd9f96c4d3e70273968fdc648dc3f71d3e60345900677baf16a',
     x86_64: '5e5997cc07cbeb557237aa597888b3f7d52e129481b30aea4b08dfa364db7911'
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
