require 'package'

class Libgudev < Package
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '0.232'
  source_url 'https://download.gnome.org/sources/libgudev/232/libgudev-232.tar.xz'
  source_sha256 'ee4cb2b9c573cdf354f6ed744f01b111d4b5bed3503ffa956cefff50489c7860'

  depends_on 'gobject_introspection'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-umockdev"   # umockdev is only for tests
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
