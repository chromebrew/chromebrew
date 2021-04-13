require 'package'

class Dbus_glib < Package
  description 'The D-Bus GLib package contains GLib interfaces to the D-Bus API.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/general/dbus-glib.html'
  version '0.110'
  license 'GPL-2 or AFL-2.1'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.110.tar.gz'
  source_sha256 '7ce4760cf66c69148f6bd6c92feaabb8812dee30846b24cd0f7395c436d7e825'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/dbus_glib-0.110-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/dbus_glib-0.110-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/dbus_glib-0.110-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/dbus_glib-0.110-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0845692e0819a80ebb4e6874dc707a07e619e12974aad74702709d7ac8840961',
     armv7l: '0845692e0819a80ebb4e6874dc707a07e619e12974aad74702709d7ac8840961',
       i686: '7ca87d44120d2bbe554e23aa71d01e4643002c77abc303e510feb8c9ea237f9f',
     x86_64: 'be9ed1170dc5c36a905ecc3387e5cdea9d5c8eb597cf233936a5095bfb55107d',
  })

  depends_on 'dbus'
  depends_on 'glib'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
