# Adapted from Arch Linux ettercap PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/ettercap/trunk/PKGBUILD

require 'package'

class Ettercap_gtk < Package
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.3.1'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/Ettercap/ettercap/archive/v0.8.3.1/ettercap-0.8.3.1.tar.gz'
  source_sha256 'd0c3ef88dfc284b61d3d5b64d946c1160fd04276b448519c1ae4438a9cdffaf3'

  binary_url({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap_gtk/0.8.3.1_armv7l/ettercap_gtk-0.8.3.1-chromeos-armv7l.tar.zst',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap_gtk/0.8.3.1_armv7l/ettercap_gtk-0.8.3.1-chromeos-armv7l.tar.zst',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap_gtk/0.8.3.1_x86_64/ettercap_gtk-0.8.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: 'f8a56ac7dcd90a7ff8ef0d343ddfc1b539c9be0282d6a36a445c879a49b91326',
      armv7l: 'f8a56ac7dcd90a7ff8ef0d343ddfc1b539c9be0282d6a36a445c879a49b91326',
      x86_64: '79fa1456b6486a304d9d4f45e7ebf7ec9a2565ebd19d0947b142676af997deeb'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'at_spi2_core' # R
  depends_on 'curl' => :build
  depends_on 'ethtool' => :build
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'geoip' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libbsd' # R
  depends_on 'libcurl' # R
  depends_on 'libnet' # R
  depends_on 'libpcap' # R
  depends_on 'libtool' => :build
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'pcre' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's,list(APPEND GTK3_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS}),list(APPEND GTK3_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS} #{CREW_PREFIX}/include/harfbuzz),g' cmake/Modules/FindGTK3.cmake"
  end

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -DINSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
            -G Ninja \
            -DENABLE_GTK=ON \
            -DENABLE_TESTS=ON \
            -DENABLE_IPV6=ON"
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
