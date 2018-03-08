require 'package'

class Sharedmimeinfo < Package
  description 'The Shared MIME-info Database specification.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info'
  version '1.9'
  source_url 'https://people.freedesktop.org/~hadess/shared-mime-info-1.9.tar.xz'
  source_sha256 '5c0133ec4e228e41bdf52f726d271a2d821499c2ab97afd3aa3d6cf43efcdc83'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sharedmimeinfo-1.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sharedmimeinfo-1.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: 'a3c19ef00a5d2623156999ed2bb594d9a3c5ca01c15917081ca40bdccad07cf8',
     x86_64: '95d620b1c585e98299d12e5de9a160a261a4acfdab135563c16f52112bd05d10',
  })
  
  depends_on 'glib'
  depends_on 'libxml2'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
