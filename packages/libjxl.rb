# Adapted from Arch Linux libjxl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libjxl/trunk/PKGBUILD

require 'package'

class Libjxl < Package
  description 'JPEG XL image format reference implementation'
  homepage 'https://jpeg.org/jpegxl/'
  version '0.7.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/libjxl/libjxl.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.7.0_armv7l/libjxl-0.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.7.0_armv7l/libjxl-0.7.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.7.0_i686/libjxl-0.7.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjxl/0.7.0_x86_64/libjxl-0.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '67fe8d51bdbfc5c3067eaf8a22641f029c352799e84e92af79cd937d061fc827',
     armv7l: '67fe8d51bdbfc5c3067eaf8a22641f029c352799e84e92af79cd937d061fc827',
       i686: 'ce2b43b309ad44f99ae30bd0ef0bdf43edca48f8168d4a70fcb66bee58dd2950',
     x86_64: '2e555f62e6339d993dd33ff730f92d03985932d4d10a0264ad844ea09e435fec'
  })

  depends_on 'brotli'
  depends_on 'gdk_pixbuf'
  depends_on 'giflib'
  depends_on 'highway'
  depends_on 'gimp' => :build
  depends_on 'libjpeg' # This needs to be turbo.
  depends_on 'xdg_utils' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'babl' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gegl' # R
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

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
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
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
