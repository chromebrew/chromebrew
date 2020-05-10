require 'package'

class Cdrkit < Package
  description 'cdrkit is a suite of programs for recording CDs and DVDs, blanking CD-RW media, creating ISO-9660 filesystem images, extracting audio CD data, and more.'
  homepage 'https://launchpad.net/cdrkit'
  version '1.1.11'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/wodim/cdrkit/cdrkit_1.1.11.orig.tar.gz'
  source_sha256 'd1c030756ecc182defee9fe885638c1785d35a2c2a297b4604c0e0dcc78e47da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cdrkit-1.1.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cdrkit-1.1.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cdrkit-1.1.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cdrkit-1.1.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6d829e8a270b9c6966998adff36696336503223c0a524c67a4760965741bc3e2',
     armv7l: '6d829e8a270b9c6966998adff36696336503223c0a524c67a4760965741bc3e2',
       i686: 'a88e5fa4e900593f11ffc492f0be315856b076398294510ed72a638b485066b8',
     x86_64: '29a22b6c7627aafed893dbe11d91c9d907c41461b76d3baa9d0da38cd228c51d',
  })

  depends_on 'cmake'
  depends_on 'libcap'

  def self.build
    system 'make clean'
    system "make CFLAGS='-I#{CREW_PREFIX}/include' LDFLAGS='-L#{CREW_LIB_PREFIX}'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
