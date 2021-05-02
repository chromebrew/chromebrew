# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '40.0'
  version "#{@_ver}-1"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/nautilus/-/archive/#{@_ver}/nautilus-#{@_ver}.tar.bz2"
  source_sha256 '9bcb93c5ce56dbe1cd2b2d0808c21a5e37cc1d098ee037b7da75c0a4a59e84e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.0-1_armv7l/nautilus-40.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.0-1_armv7l/nautilus-40.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.0-1_i686/nautilus-40.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.0-1_x86_64/nautilus-40.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '98663fed405335be9b9e297f641bd7e14edc631f43702e17a6477ba5b43368b3',
     armv7l: '98663fed405335be9b9e297f641bd7e14edc631f43702e17a6477ba5b43368b3',
       i686: '41b42d30a12e0e6597d994e8d159828ba68861b8336e46f2288451de08dc2948',
     x86_64: 'b3412b0b281875a9cd1a9433e25e345246351f9a2eedc2e91e55f4cb4259a40c'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'dconf'
  depends_on 'gdk_pixbuf'
  depends_on 'gexiv2'
  depends_on 'glib'
  depends_on 'gnome_autoar'
  depends_on 'gnome_desktop'
  depends_on 'gobject_introspection' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs'
  depends_on 'libhandy'
  depends_on 'libjpeg'
  depends_on 'libportal'
  depends_on 'pango'
  depends_on 'tracker3'
  depends_on 'tracker3_miners'

  def self.patch
    # Source has libgnome-volume-control repo as submodule
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
    -Ddocs=false \
    -Dpackagekit=false \
    -Dnetworkmanager=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
    FileUtils.touch "#{HOME}/.gtk-bookmarks"
  end
end
