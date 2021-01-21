require 'package'

class Libxfce4ui < Package
  description 'Replacement of the old libxfcegui4 library'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/libxfce4ui/4.16/libxfce4ui-4.16.0.tar.bz2"
  source_sha256 '8b06c9e94f4be88a9d87c47592411b6cbc32073e7af9cbd64c7b2924ec90ceaa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2c97cfdf36b164b7c798dc42d16b0e4abd6777b4ab4dd6c115f4b43359afa4ad',
     armv7l: '2c97cfdf36b164b7c798dc42d16b0e4abd6777b4ab4dd6c115f4b43359afa4ad',
       i686: 'aec6b72ae1c3405524e8f823746e18139f4c5a8e3855322c4a128f5d29a29186',
     x86_64: '109195c13796a024b26c3d58773555cc62bb9b373fbcb8a511816dbe63bdd043',
  })

  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'pygtk' # For gtk+
  depends_on 'xfconf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
