require 'package'

class Mate_common < Package
  description 'Common files for development of MATE packages. https://mate-desktop.org'
  homepage 'https://pub.mate-desktop.org/releases/'
  version '1.20'
  source_url 'https://pub.mate-desktop.org/releases/1.20/mate-common-1.20.0.tar.xz'
  source_sha256 '616d9c319ee892f05494570fb0f7316c10f17a1f8d15d0a9a6ae38c320161a41'

  binary_url ({
  })
  binary_sha256 ({
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
