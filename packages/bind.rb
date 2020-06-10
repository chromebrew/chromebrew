require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.14.2'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9/-/archive/v9_14_2/bind9-v9_14_2.tar.bz2'
  source_sha256 'da7d117bfc94c37874dbde635737f67c4896f4beaad27249f1f064e658fa93d9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.14.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.14.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.14.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd26cfb9fcbe3e7ca1abb6708c0a4478007cd8200fc5ef0d8d01748c8059cac8f',
     armv7l: 'd26cfb9fcbe3e7ca1abb6708c0a4478007cd8200fc5ef0d8d01748c8059cac8f',
       i686: 'f5303d850a1d90ad4c9dc0d4a8c7ffccf1d1aa679df7d422b65ea4751a8f9831',
     x86_64: '2543ca2376418d59ae4f53f80c5bc11a62eb10489feacd22c9ec0a5359165989',
  })

  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'python3'
  depends_on 'readline'

  def self.build
    system 'pip3 install ply==3.11'
    system './configure',
           '--with-seccomp',
           '--with-gost=yes',
           '--with-ecdsa=yes',
           '--with-randomdev=no',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system 'pip3 uninstall -y ply'
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I ply==3.11"
  end
end
