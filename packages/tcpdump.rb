require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.9.3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.tcpdump.org/release/tcpdump-4.9.3.tar.gz'
  source_sha256 '2cd47cb3d460b6ff75f4a9940f594317ad456cfbf2bd2c8e5151e16559db6410'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpdump/4.9.3_armv7l/tcpdump-4.9.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpdump/4.9.3_armv7l/tcpdump-4.9.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpdump/4.9.3_i686/tcpdump-4.9.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpdump/4.9.3_x86_64/tcpdump-4.9.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ead972530045f754e3b1500fe0ee09fb5374dda77bea9b57ca742353832dc533',
     armv7l: 'ead972530045f754e3b1500fe0ee09fb5374dda77bea9b57ca742353832dc533',
       i686: 'd68697adee87a20569d599cd22a4386621695f589fe282142ce6d0d2b2cddd40',
     x86_64: '0230d536910ef83bd1fb9a33c541dcb6c11b5ccbf406d5cd9b2f4fa8ea27e692'
  })

  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'libpcap'
  depends_on 'openssl'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-user=#{USER}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
