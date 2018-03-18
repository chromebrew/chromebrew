require 'package'

class Mate_calc < Package
  description 'Calculator for MATE.'
  homepage 'https://mate-desktop.org'
  version '1.20'
  source_url 'https://pub.mate-desktop.org/releases/1.20/mate-calc-1.20.0.tar.xz'
  source_sha256 'e3b075f7d0a02fb72adbf78678685888dec9402cd0ae6b04200d32009651950d'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
