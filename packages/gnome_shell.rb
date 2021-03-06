# Adapted from Arch Linux gnome-shell PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gnome-shell/trunk/PKGBUILD

require 'package'

class Gnome_shell < Package
  description 'Next generation desktop shell'
  homepage 'https://wiki.gnome.org/Projects/GnomeShell'
  version '40.beta'
  compatibility 'x86_64 , aarch64, armv7l'
  source_url "https://github.com/GNOME/gnome-shell/archive/#{version}.tar.gz"
  source_sha256 'fd929eba43ca52c1f620460be02de0c116ea7ba792e504329eb85c83e5800ada'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.beta-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_shell-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c033e58da3bd7f34d3bdb49dea3254aa18a5bd9093ed6c516e23c413aac58ac9',
     armv7l: 'c033e58da3bd7f34d3bdb49dea3254aa18a5bd9093ed6c516e23c413aac58ac9',
     x86_64: '3bffb1ccc2ca22a72c37599ece8b61c01f75fc7e3157d1e7c0ef2e7a2f47dd88'
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
  depends_on 'gtk_doc' => ':build'
  depends_on 'evolution_data_server' => ':build'
  depends_on 'gobject_introspection' => ':build'

  def self.patch
    # Source has libgnome-volume-control repo as submodule
    @git_dir = 'subprojects/gvc'
    @git_hash = '7a621180b46421e356b33972e3446775a504139c'
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
