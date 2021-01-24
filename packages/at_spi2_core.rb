require 'package'
  
class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.39.1'
  compatibility 'all'
  source_url 'https://github.com/GNOME/at-spi2-core/archive/AT_SPI2_CORE_2_39_1.tar.gz'
  source_sha256 '01db93c5f145492e973ddbace66ce85f6487a1e0cdd1b0ecdb8b67e0fbda5a45'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '601ffb2a4fa4d39fb0d91778b6d51e5b8cb6f1d594d816f663185bbc41946b64',
      armv7l: '601ffb2a4fa4d39fb0d91778b6d51e5b8cb6f1d594d816f663185bbc41946b64',
        i686: '212e32fbb4d303f51519b0f83673ad763b9e06eff185f6fffe2ce621068d68b3',
      x86_64: '43d3d871bb8ee30719b69a740ec6be0e005a6e10acf6858abf250de5e0f38832',
  })

  depends_on 'automake' => :build
  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'libxcb'
  depends_on 'gtk_doc'
  depends_on 'libtool'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
