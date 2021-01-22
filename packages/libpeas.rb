require 'package'

class Libpeas < Package
  description 'A GObject plugins library'
  homepage 'https://wiki.gnome.org/Projects/Libpeas'
  version '1.28.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libpeas/archive/libpeas-1.28.0.tar.gz'
  source_sha256 '93d2826330a5e943dcfe8d059c5885a808494ee44c0b04f72f2bb2283b4d515b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.28.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.28.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.28.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.28.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1e304a55ad539257c0ff2e1caa48671ee0c8749eb438d344d27025bc8b48c435',
      armv7l: '1e304a55ad539257c0ff2e1caa48671ee0c8749eb438d344d27025bc8b48c435',
        i686: '2fb94c73ed674c002632cc4dfd4d32ade44ed5798e13c2cb01a8ff63966169dd',
      x86_64: '1333e5f9ba1e4b516a81dfbd41cc4bf0502d4d735b250a61ef95c7c0f60073c0',
  })

  depends_on 'gtk3'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc' => ':build'
  depends_on 'pygobject' => ':build'
  depends_on 'glade' => ':build'
  depends_on 'gobject_introspection' => ':build'
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
