require 'buildsystems/autotools'

class Mate_calc < Autotools
  description 'Calculator for MATE.'
  homepage 'https://mate-desktop.org'
  version '1.28.0'
  license 'CC-BY-SA-3.0 and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-calc-#{version}.tar.xz"
  source_sha256 '804b125d1e2864b1e74af816da9b2ab8b19472b9af974437ee7355ada5e628f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd99bf797ceac21dd7a934f951029106be87b27b04b420a37c87160e190039b8c',
     armv7l: 'd99bf797ceac21dd7a934f951029106be87b27b04b420a37c87160e190039b8c',
     x86_64: 'a405830bc8557ad9a5762e8413b8202b922e2f5b9ebf931d3f77802f15395914'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gmp' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'mate_common' => :logical
  depends_on 'mpc' => :executable
  depends_on 'mpfr' => :executable
  depends_on 'pango' => :executable
  depends_on 'yelp_tools' => :executable
  depends_on 'zlib' => :executable
end
