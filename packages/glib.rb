require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.3.tar.xz'
  source_sha256 'b8e5f7397bc399d8134f3cdab7323b2210dd202510cf62a517e00dcca3488b78'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9d38ac3744e0ce1477d804a4404a841df8df298df1d639206f16830e0c5e9f20',
     armv7l: '9d38ac3744e0ce1477d804a4404a841df8df298df1d639206f16830e0c5e9f20',
       i686: '100eec0254ae2ffc34d3903da688f740bad38fec9ac3e443a2bb9c75d76337f3',
     x86_64: 'f31c6a72ee5495d2121983ee475475f45b03918e7f01f5115c4047ff216c7b82'
  })

  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'pygments'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Das_needed=false \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
