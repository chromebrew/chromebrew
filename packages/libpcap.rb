require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.tcpdump.org/release/libpcap-1.10.0.tar.gz'
  source_sha256 '8d12b42623eeefee872f123bd0dc85d535b00df4d42e865f993c40f7bfc92b1e'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpcap/1.10.0_armv7l/libpcap-1.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpcap/1.10.0_armv7l/libpcap-1.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpcap/1.10.0_i686/libpcap-1.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpcap/1.10.0_x86_64/libpcap-1.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3ec810c7c9ddc2e2d684cae52dcc69375b786f18b4f53086dc70a3b794a4a759',
     armv7l: '3ec810c7c9ddc2e2d684cae52dcc69375b786f18b4f53086dc70a3b794a4a759',
       i686: '967dcedbb55c15c68c232692a76b4a9e4a7d1accbed443c3bcc30fda952ea6ad',
     x86_64: '8afeecd5018fe6d0bb4958e08d8359ee7abd09d48633d575ac2a241ccbdbee96'
  })

  depends_on 'libnl3'

  def self.build
    system "CFLAGS='-I#{CREW_PREFIX}/include/libnl3 -flto=auto -fuse-ld=gold' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
