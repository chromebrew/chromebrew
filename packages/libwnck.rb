require 'package'

class Libwnck < Package
  description 'Library for layout and rendering of text'
  homepage 'http://www.gnome.org/'
  version '3.32.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libwnck/3.32/libwnck-3.32.0.tar.xz'
  source_sha256 '9595835cf28d0fc6af5526a18f77f2fcf3ca8c09e36741bb33915b6e69b8e3ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwnck-3.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwnck-3.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwnck-3.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwnck-3.32.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50d51f55bb6f0866732dfaf94ea2cc05dbb66651831642ffeaaed25675e758a3',
     armv7l: '50d51f55bb6f0866732dfaf94ea2cc05dbb66651831642ffeaaed25675e758a3',
       i686: 'd297914639e3b7e4bfa8bdc3cb11b58f9c786eefe480c06d5dd4b6143dd2f0e3',
     x86_64: '2551d4d2c782f4e5958e0f21c0f38ff8a36ddbecca142f81d34b26969a0e1bce',
  })

  depends_on 'startup_notification'
  depends_on 'pygtk'
  depends_on 'libxres'

  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end