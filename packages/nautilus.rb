# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  @_ver = '44.0'
  version @_ver
  license 'GPLv3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.0_armv7l/nautilus-44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.0_armv7l/nautilus-44.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.0_x86_64/nautilus-44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fb635cde6d3b7b4df435c5ab226f8519ace60edd03930628dfb7ee4fd0d05e85',
     armv7l: 'fb635cde6d3b7b4df435c5ab226f8519ace60edd03930628dfb7ee4fd0d05e85',
     x86_64: '327eef2ac9bc742575bedb967c7c49e3e19335f910815a93c0755843c38abe63'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_autoar' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'libarchive' # R
  depends_on 'libcloudproviders' # R
  depends_on 'libhandy' # R
  depends_on 'libjpeg' => :build
  depends_on 'libportal' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'tracker3_miners'
  depends_on 'tracker3' # R
  depends_on 'vulkan_icd_loader' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Ddocs=false \
    -Dpackagekit=false \
    -Dtests=headless \
    builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    FileUtils.touch "#{HOME}/.gtk-bookmarks"
  end
end
