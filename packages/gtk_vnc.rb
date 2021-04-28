require 'package'

class Gtk_vnc < Package
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.2.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtk-vnc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk_vnc/1.2.0_armv7l/gtk_vnc-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk_vnc/1.2.0_armv7l/gtk_vnc-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk_vnc/1.2.0_i686/gtk_vnc-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk_vnc/1.2.0_x86_64/gtk_vnc-1.2.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '62d85534080b53b4b3e0a20c58979db9e550a035414821d210a45fc8965da0ab',
     armv7l: '62d85534080b53b4b3e0a20c58979db9e550a035414821d210a45fc8965da0ab',
       i686: '609017642a8be0a5d309b05d07aed5665760eca14af26075c3b719fef3736dc8',
     x86_64: '5001d552bfa4155bf2c77a1e1a7ee4714125566db0b9ce1e3e3c5e88ace8057d'
  })

  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'
  depends_on 'libgcrypt'
  depends_on 'pulseaudio'

  def self.patch
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
