require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.64.1'
  source_url 'https://ftp.acc.umu.se/pub/gnome/sources/glib/2.64/glib-2.64.1.tar.xz'
  source_sha256 '17967603bcb44b6dbaac47988d80c29a3d28519210b28157c2bd10997595bbc7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'util_linux'
  depends_on 'six'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Dinternal_pcre=true builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
