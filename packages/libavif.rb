require 'buildsystems/cmake'

class Libavif < CMake
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  version '1.3.0'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91029d3d2d8a826af8fa188f06217710a2ed4ab49eb7880a356b0454d5ca2e7d',
     armv7l: '91029d3d2d8a826af8fa188f06217710a2ed4ab49eb7880a356b0454d5ca2e7d',
     x86_64: '78252aa3decc765b1488c92d447c2cc43ac629d396ec4cc83ccdeadf142d3278'
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
