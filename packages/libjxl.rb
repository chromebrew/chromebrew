# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'package'

class Libjxl < Package
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.8.1'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.1_armv7l/libjxl-0.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.1_armv7l/libjxl-0.8.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.1_x86_64/libjxl-0.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '866fca20e903b8a2c88f3aa5bab1c3276be113992249831678afa1c8b48ffe55',
     armv7l: '866fca20e903b8a2c88f3aa5bab1c3276be113992249831678afa1c8b48ffe55',
     x86_64: '3c1bfbdeb5e68d05f692d49d18f2e86c8c382b1d669013acb76ad938ada658d6'
  })

  depends_on 'asciidoc' => :build
  depends_on 'brotli'
  depends_on 'gdk_pixbuf'
  depends_on 'giflib'
  depends_on 'highway'
  depends_on 'libjpeg' # This needs to be turbo.
  depends_on 'xdg_utils' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'babl' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gegl' # R
  depends_on 'gimp' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk2' # R
  depends_on 'harfbuzz' # R
  depends_on 'ilmbase' # R
  depends_on 'json_glib' # R
  depends_on 'libpng' # R
  depends_on 'openexr' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  no_env_options

  def self.build
    system "mold -run cmake -B builddir \
          #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon')} \
          -DJPEGXL_ENABLE_BENCHMARK:BOOL='false' \
          -DJPEGXL_ENABLE_EXAMPLES:BOOL='false' \
          -DJPEGXL_ENABLE_FUZZERS:BOOL='false' \
          -DJPEGXL_ENABLE_PLUGINS:BOOL='true' \
          -DJPEGXL_ENABLE_VIEWERS:BOOL='false' \
          -DJPEGXL_FORCE_SYSTEM_BROTLI:BOOL='true' \
          -DJPEGXL_FORCE_SYSTEM_GTEST:BOOL='false' \
          -DJPEGXL_FORCE_SYSTEM_HWY:BOOL='true' \
          -DJPEGXL_BUNDLE_LIBPNG:BOOL='NO' \
          -Wdev \
          -G Ninja"
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
