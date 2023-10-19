# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'package'

class Wireshark < Package
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.0.7'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.7_armv7l/wireshark-4.0.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.7_armv7l/wireshark-4.0.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.7_i686/wireshark-4.0.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.7_x86_64/wireshark-4.0.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '151e5fc92876d26cf2961725549ccae7f2a30dbbac4775db855c332cad637dbf',
     armv7l: '151e5fc92876d26cf2961725549ccae7f2a30dbbac4775db855c332cad637dbf',
       i686: 'd4d44e2f452d3481cb2831f9ff223d1239dc92e9770da305bcd89230095e658b',
     x86_64: '219be09a131409c6868478701b2f6c27093fcd89b0ab88d62139b7a7c938f784'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libmaxminddb' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnl3' # R
  depends_on 'libpcap' # R
  depends_on 'libssh' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'opus' # R
  depends_on 'pcre2' # R
  depends_on 'qt5base' unless ARCH == 'i686'
  depends_on 'qt5multimedia' unless ARCH == 'i686'
  depends_on 'qt5svg' unless ARCH == 'i686'
  depends_on 'qt5tools' unless ARCH == 'i686'
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sbc' # R
  depends_on 'snappy' # R
  depends_on 'speexdsp' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  git_fetchtags

  def self.build
    @gui = 'true'
    case ARCH
    when 'i686'
      @gui = 'false'
    end
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DENABLE_LTO=true \
      -DBUILD_wireshark=#{@gui} \
      -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
