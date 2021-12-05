# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'package'

class Wireshark < Package
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '3.6.0'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/3.6.0_armv7l/wireshark-3.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/3.6.0_armv7l/wireshark-3.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/3.6.0_i686/wireshark-3.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/3.6.0_x86_64/wireshark-3.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '61ea40696865306311267c22ef44c78d3dfbb7836c54be34991c781b0d39308a',
     armv7l: '61ea40696865306311267c22ef44c78d3dfbb7836c54be34991c781b0d39308a',
       i686: '8a0e904fa243b649d85d729c7d6ab2875fd3c9a0d0124c2dc9e9cfd780bfe30d',
     x86_64: 'd6b21c3d27bf7e8db7ee42b83c794c494baee18bda7beb18ec5fa556b0a43db2'
  })

  depends_on 'asciidoctor' => :build
  depends_on 'c_ares'
  depends_on 'libmaxminddb'
  depends_on 'libpcap'
  depends_on 'qttools' unless ARCH == 'i686'
  depends_on 'qtmultimedia' unless ARCH == 'i686'
  depends_on 'qtsvg' unless ARCH == 'i686'

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
