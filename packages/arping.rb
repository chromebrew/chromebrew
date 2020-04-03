require 'package'

class Arping < Package
  description 'ARP Ping'
  homepage 'https://github.com/ThomasHabets/arping'
  version '2.21'
  source_url 'https://github.com/ThomasHabets/arping/archive/arping-2.21.tar.gz'
  source_sha256 '7bf550571aa1d4a2b00878bb2f6fb857a09d30bf65411c90d62afcd86755bd81'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/arping-2.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/arping-2.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/arping-2.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/arping-2.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e85f871e84dce5360c1b50eccaa3ae5a1beaea9f89120cf0da19ffcabcf19fa1',
     armv7l: 'e85f871e84dce5360c1b50eccaa3ae5a1beaea9f89120cf0da19ffcabcf19fa1',
       i686: 'b808583d44c865ac023986b02e4c1ad8d9fbdbd12540775f620953b01a810e50',
     x86_64: '46c5c7e174bb800bb317e09df6f77448040c7aeda137a23e2b8ed85ecb852fcb',
  })

  depends_on 'libpcap'
  depends_on 'libnet'

  def self.build
    system './bootstrap.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
