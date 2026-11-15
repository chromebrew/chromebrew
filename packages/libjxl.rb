# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'buildsystems/cmake'

class Libjxl < CMake
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.13.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61ac0bd0c153a8e2b42530e2ea2c6ed5044b77688bd90251c85ef0021bec2691',
     armv7l: '61ac0bd0c153a8e2b42530e2ea2c6ed5044b77688bd90251c85ef0021bec2691',
     x86_64: '81393e9fdaf27805ff10f69fa993f4e68ab27fe907162634c0df08f471ea7013'
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
