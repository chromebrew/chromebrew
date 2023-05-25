# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'package'

class Wireshark < Package
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.0.6'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.6_armv7l/wireshark-4.0.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.6_armv7l/wireshark-4.0.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.6_i686/wireshark-4.0.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.6_x86_64/wireshark-4.0.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '017257adc58efbfcb50a218505d0f36954d3ff25a475df7b3e34858c6f6b22b3',
     armv7l: '017257adc58efbfcb50a218505d0f36954d3ff25a475df7b3e34858c6f6b22b3',
       i686: '7b505459f5f8e8a98cb64c98e32190300e9ffbcb4f832528f8e3ca3d30c4eb92',
     x86_64: 'd9a064f716807a3354ea0f09971e3c9a54a46dd5fa15add2e5e1719d3735437d'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc' # R
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
  depends_on 'qtbase' unless ARCH == 'i686'
  depends_on 'qtmultimedia' unless ARCH == 'i686'
  depends_on 'qtsvg' unless ARCH == 'i686'
  depends_on 'qttools' unless ARCH == 'i686'
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
