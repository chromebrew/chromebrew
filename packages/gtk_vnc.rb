require 'package'

class Gtk_vnc < Package
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.2.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtk-vnc/-/archive/v#{version}/gtk-vnc-v#{version}.tar.bz2"
  source_sha256 '125af97fdd43a570e62c351b53c26bd82c9cb1146b7f72d9d594e6e07dde78d9'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gtk_vnc-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gtk_vnc-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gtk_vnc-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gtk_vnc-1.2.0-chromeos-x86_64.tar.xz'
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
    # Source has keycodemapdb repo as submodule
    @git_dir = 'subprojects/keycodemapdb'
    @git_hash = '6280c94f306df6a20bbc100ba15a5a81af0366e6'
    @git_url = 'https://gitlab.com/keycodemap/keycodemapdb.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
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
