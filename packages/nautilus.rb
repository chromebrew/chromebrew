# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '40.2'
  version @_ver
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.2_armv7l/nautilus-40.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.2_armv7l/nautilus-40.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.2_i686/nautilus-40.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/40.2_x86_64/nautilus-40.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8417f762f5857edc7fe0dcfc64fac7a488ec6668f4ed19cf7a4f09b4c7821bbf',
     armv7l: '8417f762f5857edc7fe0dcfc64fac7a488ec6668f4ed19cf7a4f09b4c7821bbf',
       i686: '3bc83cc9f2b407584434365c9ac8f95a1b0b691d6cb6f44bc4fadda5a1283ce2',
     x86_64: 'ddd67ddee30dab06fd42c6b74bbf50a6cee0ab43071a363f283ff4d66b848ba0'
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
