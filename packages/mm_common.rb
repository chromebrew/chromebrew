require 'package'

class Mm_common < Package
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  version '0.9.11'
  compatibility 'all'
  source_url 'https://github.com/GNOME/mm-common/archive/0.9.11.tar.gz'
  source_sha256 'dbc06ffe4645f13565f13a2d526a14095b21906a4a13db146062052dbd683887'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mm_common-0.9.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mm_common-0.9.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mm_common-0.9.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mm_common-0.9.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '11a1c1bcea2259ac1195c91d2ba0a11b755d5f078d3cd443496e9a22f267f5ef',
     armv7l: '11a1c1bcea2259ac1195c91d2ba0a11b755d5f078d3cd443496e9a22f267f5ef',
       i686: 'b0c118d1d1fbdf5d7c1e8b351d965aeb4c98fe227b145833151b2b82b667f997',
     x86_64: '441c5e007c75a82fbc8cf2335e1e591aa29902d6b6b0199b5f1da346eabb9a43',
  })

  def self.build
    system "./autogen.sh"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-network"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
