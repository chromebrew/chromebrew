# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'package'

class Wireshark < Package
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.0.0'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.0_armv7l/wireshark-4.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.0_armv7l/wireshark-4.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.0_i686/wireshark-4.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.0.0_x86_64/wireshark-4.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '542247f18443b9aa3f0a77a59afd0e23f5af8aef2fc52a131f5322aed38f7df2',
     armv7l: '542247f18443b9aa3f0a77a59afd0e23f5af8aef2fc52a131f5322aed38f7df2',
       i686: '4de711ee8aad78da1537ba7a93c97b4d3d2e843b3ccd7af0f57e12e55ab3b5b8',
     x86_64: '60eee74f73306e3339da92c28e1e14202ebaaff3046521eab46eb8fa4a091b7c'
  })

  depends_on 'ruby_asciidoctor' => :build
  depends_on 'c_ares'
  depends_on 'libmaxminddb'
  depends_on 'libcap'
  depends_on 'libpcap'
  depends_on 'glib'
  depends_on 'qttools' unless ARCH == 'i686'
  depends_on 'qtmultimedia' unless ARCH == 'i686'
  depends_on 'qtsvg' unless ARCH == 'i686'
  depends_on 'brotli' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnl3' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'opus' # R
  depends_on 'pcre2' # R
  depends_on 'qtbase' # R
  depends_on 'sbc' # R
  depends_on 'snappy' # R
  depends_on 'speexdsp' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  @gui = 'true'
  case ARCH
  when 'i686'
    @gui = 'false'
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DENABLE_LTO=true \
      -DBUILD_wireshark=#{@gui} \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
