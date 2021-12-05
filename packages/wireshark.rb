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
    aarch64: '808bbff0525d26fb23159c6a64f3eb1d28716baffd01af5a7a510ac1bface476',
     armv7l: '808bbff0525d26fb23159c6a64f3eb1d28716baffd01af5a7a510ac1bface476',
       i686: 'f5c2695433f3e5bc6d3874fb4155a759d0e035240c4edcfb1edd33a19923e568',
     x86_64: 'c8461d43290fc2671fa561de99ebcbf8bcd836f306111bc6ef057cd5c5404296'
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
