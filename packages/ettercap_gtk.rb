# Adapted from Arch Linux ettercap PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/ettercap/trunk/PKGBUILD

require 'buildsystems/cmake'

class Ettercap_gtk < CMake
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.4.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Ettercap/ettercap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f153b80b9d20b8f4632060152179b0e16c50a6d9b63704dee9035c3ea934eb84',
     armv7l: 'f153b80b9d20b8f4632060152179b0e16c50a6d9b63704dee9035c3ea934eb84',
     x86_64: '7299f73c6d22ca35b84dafb9c1f2f12af93a2e80993e0f031a05afd49557ecdc'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'check' => :build
  depends_on 'curl' => :library
  depends_on 'ethtool' => :build
  depends_on 'ettercap' => :executable
  depends_on 'freetype' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'geoip' => :library
  depends_on 'ghostscript' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libbsd' => :library
  depends_on 'libiconv' => :library
  depends_on 'libmaxminddb' => :library
  depends_on 'libnet' => :library
  depends_on 'libpcap' => :library
  depends_on 'libtool' => :build
  depends_on 'ncurses' => :library
  depends_on 'openssl' => :library
  depends_on 'pango' => :library
  depends_on 'pcre' => :library
  depends_on 'pcre2' => :library
  depends_on 'zlib' => :library

  def self.patch
    system "sed -i 's,list(APPEND GTK3_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS}),list(APPEND GTK3_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS} #{CREW_PREFIX}/include/harfbuzz),g' cmake/Modules/FindGTK3.cmake"
  end

  cmake_options " \
    -DINSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
    -DENABLE_GTK=ON \
    -DENABLE_TESTS=ON \
    -DENABLE_IPV6=ON"
end
