# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'package'

class Nautilus < Package
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  version '44.2'
  license 'GPLv3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.2_armv7l/nautilus-44.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.2_armv7l/nautilus-44.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nautilus/44.2_x86_64/nautilus-44.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7aa9ac926a916451288e17fa7eff600afb79530c9eade1bbf7724049ad5a9059',
     armv7l: '7aa9ac926a916451288e17fa7eff600afb79530c9eade1bbf7724049ad5a9059',
     x86_64: '8bad0c1b95bd31109c9df5811aeeda5a15d18e2b2756523136b9e072fca53af0'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'gcc_lib' # R
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
  depends_on 'vulkan_headers' => :build
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
