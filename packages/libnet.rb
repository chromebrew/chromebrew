require 'package'

class Libnet < Package
  description 'A portable framework for low-level network packet construction'
  homepage 'https://github.com/libnet/libnet'
  version '1.2'
  source_url 'https://github.com/libnet/libnet/releases/download/v1.2/libnet-1.2.tar.gz'
  source_sha256 'caa4868157d9e5f32e9c7eac9461efeff30cb28357f7f6bf07e73933fb4edaa7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnet-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnet-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnet-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnet-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f5470d38812054ec3e6debbcaa9f40bf8af6d466586ac5b468934308510ad60b',
     armv7l: 'f5470d38812054ec3e6debbcaa9f40bf8af6d466586ac5b468934308510ad60b',
       i686: '7816e92e1ade988289088c4a7732716b22747b3e4b1e8017a65e37d65c01a116',
     x86_64: '41332bb8b21536bc8fcb14b9efb87d7caa4dff2c0942a4ef5d43a38a48e969c6',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
