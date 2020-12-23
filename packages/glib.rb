require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.1.tar.xz'
  source_sha256 '3b3409fe3a93f9e9f6f5dc9cd8405edfd7513b289589987e568369e627d3350c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60c7e465018402a5322562096f4d97d7847f5a3f030d0e3c25368032fc42ed59',
     armv7l: '60c7e465018402a5322562096f4d97d7847f5a3f030d0e3c25368032fc42ed59',
       i686: '99556392d96794d4f36fd42a7a20adcc59f6af70eb5571740a65e2bf49922a4e',
     x86_64: '78ef204fddb935fa158b1716f891881b979e26215be91ca692bc07af7af7c2e6',
  })

  depends_on 'pcre2'
  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'

  ENV['CFLAGS'] = "-fno-stack-protector"
  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dgtk_doc=false \
    -Diconv=external \
    -Dinternal_pcre=true \
    build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
