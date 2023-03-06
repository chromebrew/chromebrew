# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '43.0'
  version @_ver
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/43.0_armv7l/nautilus-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/43.0_armv7l/nautilus-43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/43.0_i686/nautilus-43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/43.0_x86_64/nautilus-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9cdfef60bcf5ce680cefad72b0bba5c21657a047ddcc0b3cd54659895b5101b1',
     armv7l: '9cdfef60bcf5ce680cefad72b0bba5c21657a047ddcc0b3cd54659895b5101b1',
       i686: '88c4af0dca722b93a26ef5b87fedb7f86bf876142e5276f6f12aac11440694fa',
     x86_64: 'ba307bfc14bc48fee9f6ef65e74e747ba1bc28246c65fcafec03e6e248f01676'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf'
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glib' # R
  depends_on 'gnome_autoar' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs'
  depends_on 'libcloudproviders' # R
  depends_on 'libhandy' # R
  depends_on 'libjpeg'
  depends_on 'libportal' # R
  depends_on 'pango' # R
  depends_on 'tracker3_miners'
  depends_on 'tracker3' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'gcc' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Ddocs=false \
    -Dpackagekit=false \
    -Dtests=headless \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    FileUtils.touch "#{HOME}/.gtk-bookmarks"
  end
end
