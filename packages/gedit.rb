require 'package'

class Gedit < Package
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '40.0'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gedit/-/archive/#{version}/gedit-#{version}.tar.bz2"
  source_sha256 'b7ac78774fe2eadd09a9d91d19b2596ebd3388f2d3d1cf3cbac81cba649c399a'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gedit-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gedit-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/gedit-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/gedit-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7f976a406dd8e8137d0aa7217c1d75fbee756a028c8315c386c41dfb4c3b57f6',
     armv7l: '7f976a406dd8e8137d0aa7217c1d75fbee756a028c8315c386c41dfb4c3b57f6',
       i686: '4c495f8e7e307103ded815bc217b8bc021e7957a760f0e820a587e59f53d9569',
     x86_64: 'd908a24c2ba3085980ad3ff0afbdd3c3996bbffb21bc1c538cb3d21364a8acd5'
  })

  depends_on 'amtk'
  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gspell'
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'libpeas'
  depends_on 'pango'
  depends_on 'pygobject'
  depends_on 'tepl_6'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  def self.patch
    # Source has libgd repo as submodule
    @git_dir = 'subprojects/libgd'
    @git_hash = 'c7c7ff4e05d3fe82854219091cf116cce6b19de0'
    @git_url = 'https://gitlab.gnome.org/GNOME/libgd.git'
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
    -Drequire_all_tests=false \
    -Duser_documentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
