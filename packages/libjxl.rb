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
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a52af3b5ec2acc26610eff548685cceb52a107c16c36a9d58c07bd390e433cbd',
     armv7l: 'a52af3b5ec2acc26610eff548685cceb52a107c16c36a9d58c07bd390e433cbd',
     x86_64: '4e906d35e252d39c3c1351b9fd0b21dcbbaafe00b74988b10919a66d4bffd7e5'
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
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' => :build
  depends_on 'highway' # R
  depends_on 'json_glib' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'openexr' # R
  depends_on 'pango' => :build
  depends_on 'xdg_utils' => :build
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
