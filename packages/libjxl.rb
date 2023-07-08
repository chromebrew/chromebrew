# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'package'

class Libjxl < Package
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.8.2'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.2_armv7l/libjxl-0.8.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.2_armv7l/libjxl-0.8.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.8.2_x86_64/libjxl-0.8.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '04a482d3aba8e5bcb2e8583a8fdcd230345bd3fdce26b744847f73c6b74cccfc',
     armv7l: '04a482d3aba8e5bcb2e8583a8fdcd230345bd3fdce26b744847f73c6b74cccfc',
     x86_64: 'a851f15f32b4a9c2f660acb67b7adc325a233073625ae3e2c3a2eaa45287f656'
  })

  depends_on 'asciidoc' => :build
  depends_on 'at_spi2_core' => :build
  depends_on 'babl' => :build
  depends_on 'brotli' # R
  depends_on 'freetype' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gegl' => :build
  depends_on 'giflib' # R
  depends_on 'gimp' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk2' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'highway' # R
  depends_on 'ilmbase' # R
  depends_on 'json_glib' => :build
  depends_on 'libjpeg' # R This needs to be turbo.
  depends_on 'libpng' # R
  depends_on 'openexr' # R
  depends_on 'pango' => :build
  depends_on 'xdg_utils' => :build
  depends_on 'zlibpkg' => :build

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
