require 'package'

class Libgudev < Package
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '234-1c7e'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libgudev/archive/1c7e05b40b92b67dac7a6cd27b70ba08956e4815.zip'
  source_sha256 '5ecb0c8ca76b6da7c7ad01f947c407f3670362bf5d3244075928dd86e040fcc4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-234-1c7e-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-234-1c7e-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-234-1c7e-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgudev-234-1c7e-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e636f1df415de3dddf08c3326d633b8bdf0223130e50cb2f62c5916b641c152a',
     armv7l: 'e636f1df415de3dddf08c3326d633b8bdf0223130e50cb2f62c5916b641c152a',
       i686: 'f4fb01f5d16cd38b890a85c501bfb9c22a29b8ad7a759430275b6a490d798795',
     x86_64: '0980fde25a7a552e3f672d63c50e350a369667b9dbc69191635341ca64937f76'
  })

  depends_on 'gobject_introspection'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
