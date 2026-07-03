# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'buildsystems/cmake'

class Libjxl < CMake
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.12.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cbd22376c49d3367dd8851777b5ac40c05ffa1419d036ebe63a8b6b6700beb9',
     armv7l: '6cbd22376c49d3367dd8851777b5ac40c05ffa1419d036ebe63a8b6b6700beb9',
     x86_64: '9476194524d082fc719658cf716db3a8a2d1d0eab9f53174e2e65bac56dcbe8f'
  })

  depends_on 'at_spi2_core' => :build
  depends_on 'babl' => :build
  depends_on 'brotli' => :library
  depends_on 'freetype' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'gegl' => :build
  depends_on 'giflib' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :build
  depends_on 'highway' => :library
  depends_on 'json_glib' => :build
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libxslt' => :build
  depends_on 'openexr' => :executable
  depends_on 'pango' => :build
  depends_on 'py3_asciidoc' => :build
  depends_on 'xdg_utils' => :build
  depends_on 'zlib' => :executable

  no_env_options

  cmake_options "-DJPEGXL_ENABLE_BENCHMARK:BOOL='false' \
          -DJPEGXL_ENABLE_EXAMPLES:BOOL='false' \
          -DJPEGXL_ENABLE_FUZZERS:BOOL='false' \
          -DJPEGXL_ENABLE_PLUGINS:BOOL='true' \
          -DJPEGXL_ENABLE_VIEWERS:BOOL='false' \
          -DJPEGXL_FORCE_SYSTEM_BROTLI:BOOL='true' \
          -DJPEGXL_FORCE_SYSTEM_GTEST:BOOL='false' \
          -DJPEGXL_FORCE_SYSTEM_HWY:BOOL='true' \
          -DJPEGXL_BUNDLE_LIBPNG:BOOL='NO'"
end
