require 'package'

class Mate_common < Package
  description 'Common files for development of MATE packages.'
  homepage 'https://mate-desktop.org'
  version '1.20'
  compatibility 'all'
  source_url 'https://pub.mate-desktop.org/releases/1.20/mate-common-1.20.0.tar.xz'
  source_sha256 '616d9c319ee892f05494570fb0f7316c10f17a1f8d15d0a9a6ae38c320161a41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_common-1.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mate_common-1.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mate_common-1.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_common-1.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8e420843837ccdb2883abd53c46667444499db3cf041a907af29d4bed435e1d',
     armv7l: 'd8e420843837ccdb2883abd53c46667444499db3cf041a907af29d4bed435e1d',
       i686: 'f7a9d18c6c0a7f10828d0bc4528dd0b67405e0388287123516b04e6d80361223',
     x86_64: 'd04c069aee911be73e5c80675e15a6bdfe3381432fc8bf293d6c29a592412694',
  })

  depends_on 'gtk_doc'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
end
