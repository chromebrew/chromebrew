require 'package'

class Libxfce4ui < Package
  description 'Replacement of the old libxfcegui4 library'
  homepage 'https://xfce.org/'
  version '4.15.3'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/libxfce4ui/4.15/libxfce4ui-4.15.3.tar.bz2'
  source_sha256 'ce89419720da0fa84a3bb46bc447564c5800057c026c272ae0b016918c0a9307'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.15.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.15.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.15.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4ui-4.15.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '54ae66c12fc66405c48554cc4d9e439e84a65da3cf438f907febbc15f76eadb7',
     armv7l: '54ae66c12fc66405c48554cc4d9e439e84a65da3cf438f907febbc15f76eadb7',
       i686: '91273a8ee09968a855c910684b7b5d4c388f6c53f19c7965b5265fc456a22d92',
     x86_64: 'c41174c81ff48917e9e89f99d970ff716261247ab0a8cfd0ae17ebfe85e69cde',
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
