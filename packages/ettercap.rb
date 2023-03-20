# Adapted from Arch Linux ettercap PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/ettercap/trunk/PKGBUILD

require 'package'

class Ettercap < Package
  description 'Network sniffer/interceptor/logger for ethernet LANs'
  homepage 'https://ettercap.github.com/ettercap/'
  version '0.8.3.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Ettercap/ettercap/archive/v0.8.3.1/ettercap-0.8.3.1.tar.gz'
  source_sha256 'd0c3ef88dfc284b61d3d5b64d946c1160fd04276b448519c1ae4438a9cdffaf3'

  binary_url({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap/0.8.3.1_armv7l/ettercap-0.8.3.1-chromeos-armv7l.tar.zst',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap/0.8.3.1_armv7l/ettercap-0.8.3.1-chromeos-armv7l.tar.zst',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap/0.8.3.1_i686/ettercap-0.8.3.1-chromeos-i686.tar.zst',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ettercap/0.8.3.1_x86_64/ettercap-0.8.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: 'e777dff6d81b611460dfaded82b8091b38e091c2feb5056536121535f86f045f',
      armv7l: 'e777dff6d81b611460dfaded82b8091b38e091c2feb5056536121535f86f045f',
        i686: 'd7c1019cc15151b200797f88d915f0877881c32408ae89efb7f4c304f137438c',
      x86_64: 'e24fe09a30a95396459a131d4e8e90965551572110318f8b4708789ebebba209'
  })

  depends_on 'curl' => :build
  depends_on 'ethtool' => :build
  depends_on 'geoip' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'curl' # R
  depends_on 'libnet' # R
  depends_on 'libpcap' # R
  depends_on 'libtool' => :build
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'pcre' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja \
            -DINSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
            -DENABLE_GTK=OFF \
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
