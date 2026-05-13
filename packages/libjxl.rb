# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'buildsystems/cmake'

class Libjxl < CMake
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.11.2'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd856c7326760e3f5f5f93ddaf40ca930651cf572ca8312ccb9daa99231d3e79c',
     armv7l: 'd856c7326760e3f5f5f93ddaf40ca930651cf572ca8312ccb9daa99231d3e79c',
     x86_64: '30d633e8a47f21008c4fc3011dbd88cbf540e9aa60122aa360365bd8282461c3'
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
  depends_on 'harfbuzz' => :build
  depends_on 'highway' => :library
  depends_on 'json_glib' => :build
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
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
