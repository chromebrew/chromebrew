require 'package'

class Glib2 < Package
  description 'Low level core library'
  version '2.66.3'
  source_url 'https://gitlab.gnome.org/GNOME/glib/-/archive/2.66.3/glib-2.66.3.tar.bz2'
  source_sha256 'f1c58a0fe4557f38d2b9355b5f671506af752556b26a467f8348126e2578bb3b'

  depends_on 'pcre2'
  depends_on 'libffi'
  depends_on 'gettext' => ':build'
  depends_on 'shared_mime_info' => ':build'
  depends_on 'util_linux' => ':build'

  ENV['CFLAGS'] = "-fno-stack-protector"
  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=enabled \
    -Dman=false \
    -Dgtk_doc=false \
    -Diconv=external \
    -Dsysprof:enable_gtk=true \
    build"
    system "meson configure build"
    system "ninja -C build"
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
