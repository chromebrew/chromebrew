require 'buildsystems/cmake'

class Libavif < CMake
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  version '1.3.0-1'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31bf34948e97975e1ca0f91627da1696280e8d3ce99b69c278e66d3a0e51b8ff',
     armv7l: '31bf34948e97975e1ca0f91627da1696280e8d3ce99b69c278e66d3a0e51b8ff',
     x86_64: '326b30866bffcf96ebc358dc231479c0b237c2965eb1744602f7bd1d7c21b4e9'
  })

  depends_on 'dav1d' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libaom' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libwebp' => :build
  depends_on 'libxml2' # R
  depends_on 'libyuv' # R
  depends_on 'nasm' => :build
  depends_on 'pandoc' => :build
  depends_on 'pkgconf' => :build
  depends_on 'rav1e' => :build
  depends_on 'svt_av1' => :build
  depends_on 'zlib' # R

  gnome

  cmake_options '-DAVIF_BUILD_APPS=ON \
      -DAVIF_CODEC_AOM=ON \
      -DAVIF_CODEC_DAV1D=ON \
      -DAVIF_CODEC_RAV1E=ON \
      -DAVIF_CODEC_SVT=ON \
      -DAVIF_BUILD_GDK_PIXBUF=ON \
      -DAVIF_BUILD_MAN_PAGES=OFF \
      -DAVIF_LIBXML2=SYSTEM'
end
