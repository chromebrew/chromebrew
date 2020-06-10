require 'package'

class Nss_mdns < Package
  description 'NSS module for Multicast DNS name resolution'
  homepage 'https://salsa.debian.org/debian/nss-mdns'
  version '0.14.1'
  compatibility 'all'
  source_url 'http://http.debian.net/debian/pool/main/n/nss-mdns/nss-mdns_0.14.1.orig.tar.gz'
  source_sha256 'a2094101b735cade45048764ea594bdae2bfa9399837f3c852a5b264416e9c8c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nss_mdns-0.14.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nss_mdns-0.14.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nss_mdns-0.14.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nss_mdns-0.14.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f563823a9c3c3d9946900151e661977d35ba78e75a1e864e71bccceb66536810',
     armv7l: 'f563823a9c3c3d9946900151e661977d35ba78e75a1e864e71bccceb66536810',
       i686: '3d485296384622270f77e90f45ed7a1111aeaa55c8db2fff8bfc8d1790558a84',
     x86_64: '9d1ef607505356407946f743b4bd09dc659a83d0b003c0c9eaf724277ccc0a84',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
