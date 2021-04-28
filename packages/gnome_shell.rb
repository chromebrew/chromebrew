require 'package'

class Gnome_shell < Package
  description 'Next generation desktop shell'
  homepage 'https://wiki.gnome.org/Projects/GnomeShell'
  version '40.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/GNOME/gnome-shell/archive/#{version}.tar.gz"
  source_sha256 '29567d94787e4b8db2723caeaf230ee1eba6b53072592c9269a24973909aaca3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.0_armv7l/gnome_shell-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.0_armv7l/gnome_shell-40.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_shell/40.0_x86_64/gnome_shell-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '31335a6996bc1638c4e63497684b7f3f9b90eb016e10aedaa9c96848190609c0',
     armv7l: '31335a6996bc1638c4e63497684b7f3f9b90eb016e10aedaa9c96848190609c0',
     x86_64: '4e933fabbc5cab93e25579de3958cdcde55d7d11c1ef13a6902c5775fb0d925c'
  })

  depends_on 'gcr'
  depends_on 'gjs'
  depends_on 'ibus'
  depends_on 'mutter'
  depends_on 'sassc'
  depends_on 'asciidoc'
  depends_on 'startup_notification'
  depends_on 'gnome_autoar'
  depends_on 'upower'
  depends_on 'gnome_session'
  depends_on 'gnome_settings_daemon'
  depends_on 'gtk_doc' => :build
  depends_on 'evolution_data_server' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'mutter'

  def self.patch
    # Source has libgnome-volume-control repo as submodule
    @git_dir = 'subprojects/gvc'
    @git_hash = 'c5ab6037f460406ac9799b1e5765de3ce0097a8b'
    @git_url = 'https://gitlab.gnome.org/GNOME/libgnome-volume-control.git'
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
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgtk_doc=true \
    -Dsystemd=false \
    -Dnetworkmanager=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
