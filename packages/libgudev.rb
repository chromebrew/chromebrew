require 'package'

class Libgudev < Package
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '0.232'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libgudev/232/libgudev-232.tar.xz'
  source_sha256 'ee4cb2b9c573cdf354f6ed744f01b111d4b5bed3503ffa956cefff50489c7860'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-0.232-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-0.232-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-0.232-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-0.232-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd45d9087a7128ca0b5c39dac0858728cd01f711dd57c3e8b1e716a85945cc7b8',
     armv7l: 'd45d9087a7128ca0b5c39dac0858728cd01f711dd57c3e8b1e716a85945cc7b8',
       i686: '8c9b9115d790ff7ba9d7ab4cc48aa9312c07c273141174acc02a546d20db25eb',
     x86_64: '3c41340787b2f362448cf8c32b2a00814e190bd2028605a6b925589d1fb177a1',
  })

  depends_on 'gobject_introspection'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-umockdev"   # umockdev is only for tests
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
