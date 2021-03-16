require 'package'

class Gnome_shell < Package
  description 'Next generation desktop shell'
  homepage 'https://wiki.gnome.org/Projects/GnomeShell'
  version '40.rc'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/GNOME/gnome-shell/archive/#{version}.tar.gz"
  source_sha256 '76fcbb7d4ac829a1a1287feea40f3bcebc8e5ba225bb8231707cee09f53d44a0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.rc-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6bdc526bcf41f9348522a17ca9aefe8f437b87ba06bdb552dfc22607b5256f77',
     armv7l: '6bdc526bcf41f9348522a17ca9aefe8f437b87ba06bdb552dfc22607b5256f77',
     x86_64: '30b92776aaa8345bb32084d14675ffe60a01d985cee4eeecd304fdc27d693f8b'
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
  depends_on 'gtk_doc' => ':build'
  depends_on 'evolution_data_server' => ':build'
  depends_on 'gobject_introspection' => ':build'
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
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
