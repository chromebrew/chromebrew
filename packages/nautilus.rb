# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '40.1'
  version @_ver
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.1_armv7l/nautilus-40.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.1_armv7l/nautilus-40.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.1_i686/nautilus-40.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.1_x86_64/nautilus-40.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5be1b22e7f4c93ea940558f5cfcb7e33c7abbf86d3c2b8cc3ac039c1ca946215',
     armv7l: '5be1b22e7f4c93ea940558f5cfcb7e33c7abbf86d3c2b8cc3ac039c1ca946215',
       i686: '66f98e53dd52bd1670d229845b969964fa1be2bbce2419db006defa4919dc5b4',
     x86_64: '2df5a25aa14395965a8891b3917044537b7faf89dd45b49b46eab331e9379e0f'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'atk' # R
  depends_on 'cairo' # R
  depends_on 'dconf'
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glib' # R
  depends_on 'gnome_autoar' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gst_plugins_base' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs'
  depends_on 'libhandy' # R
  depends_on 'libjpeg'
  depends_on 'libportal' # R
  depends_on 'pango' # R
  depends_on 'tracker3_miners'
  depends_on 'tracker3' # R

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
