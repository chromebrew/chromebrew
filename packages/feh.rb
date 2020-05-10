require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.1.1'
  compatibility 'all'
  source_url 'https://feh.finalrewind.org/feh-3.1.1.tar.bz2'
  source_sha256 '61d0242e3644cf7c5db74e644f0e8a8d9be49b7bd01034265cc1ebb2b3f9c8eb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/feh-3.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/feh-3.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/feh-3.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/feh-3.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3078205c170c198443f34de67e203553706e37d2e0e6922a6da19eab2a6fc01b',
     armv7l: '3078205c170c198443f34de67e203553706e37d2e0e6922a6da19eab2a6fc01b',
       i686: '607aa603469570597246fbb5e4947546eede0cc86856b3da93ad366b1d038ce2',
     x86_64: '4183106490b301341bb7d8c4cf37f6071e61231580c5d2d6ff1e108874c681f7',
  })

  depends_on 'curl'
  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'sommelier'

  def self.build
    system "sed -i 's,gtk-update-icon-cache,gtk-update-icon-cache -t,g' Makefile"
    system 'make'
  end

  def self.install
    system "make",
           "PREFIX=#{CREW_PREFIX}",
           "ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons",
           "DESTDIR=#{CREW_DEST_DIR}",
           "install",
           "app=1"
  end
end
