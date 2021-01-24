require 'package'

class Tepl < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '5.0.1'
  compatibility 'all'
  source_url 'https://github.com/GNOME/tepl/archive/5.0.1.tar.gz'
  source_sha256 '2dda3ed2bd16742f6d0fc6d602448eaa2e40b9c967b88599add2338d6fa590e7'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tepl-5.0.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tepl-5.0.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/tepl-5.0.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tepl-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'fac5fa0cbfa9a258381e522e4f79470e26310e1229a82037e96371c1d626eaa4',
      armv7l: 'fac5fa0cbfa9a258381e522e4f79470e26310e1229a82037e96371c1d626eaa4',
        i686: 'a66efc98a81bb4e48a5ee3b5e508958ec4a66cde1732c68ca2ef87745e4da7d4',
      x86_64: 'c66160cceeee02eeacc0f8f52391140bcf446dc616f87689a9c36c165683b799',
  })

  depends_on 'amtk'
  depends_on 'gtksourceview'
  depends_on 'uchardet'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
