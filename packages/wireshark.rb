# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'package'

class Wireshark < Package
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.0.5'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.5_armv7l/wireshark-4.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.5_armv7l/wireshark-4.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.5_i686/wireshark-4.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.5_x86_64/wireshark-4.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e5b718b77a4ffe92b15910376f2c9efabcbb4191c996a2fa436ee58a83978436',
     armv7l: 'e5b718b77a4ffe92b15910376f2c9efabcbb4191c996a2fa436ee58a83978436',
       i686: '4879cbf58ce9042ab231a5e3e67714ba4ab1e4f70f3803e16b84c0e2a1d7bf87',
     x86_64: '7b8c4f1a3655d18caba8304a93f0773d703c7def5894c879982f081a66d1f15b'
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
