# Adapted from Arch Linux libgxps PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgxps/trunk/PKGBUILD

require 'package'

class Libgxps < Package
  description 'XPS Documents library'
  homepage 'https://wiki.gnome.org/Projects/libgxps'
  version '0.3.2'
  license 'GPL2'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libgxps/-/archive/#{version}/libgxps-#{version}.tar.bz2"
  source_sha256 'ffbc656e801233a64ea5b6ab5532691e8b91f72cce3ea957615fe8523696d42a'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libgxps-0.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libgxps-0.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libgxps-0.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libgxps-0.3.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '47a8cac375a3ea3dace3d0498c79511d3973b2e39b6fd8d8593804e6de84dfeb',
     armv7l: '47a8cac375a3ea3dace3d0498c79511d3973b2e39b6fd8d8593804e6de84dfeb',
       i686: '7b6f550b505c2453841539b0ce36b5d8404ab098bdc2fa8f8c5f7f27cdda6ac8',
     x86_64: '87bf32455bded966594a39131bf79ad198e06617df4ccc0327932c413b3d78b6'
  })

  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'lcms'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'libpaper'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'openjpeg'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
