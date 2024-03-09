# Adapted from Arch Linux libgxps PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgxps/trunk/PKGBUILD

require 'package'

class Libgxps < Package
  description 'XPS Documents library'
  homepage 'https://wiki.gnome.org/Projects/libgxps'
  @_ver = '0.3.2'
  version "#{@_ver}-2"
  license 'GPL2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/libgxps/-/archive/#{@_ver}/libgxps-#{@_ver}.tar.bz2"
  source_sha256 'ffbc656e801233a64ea5b6ab5532691e8b91f72cce3ea957615fe8523696d42a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1461554706deed2492e3b07ce9bca2d2902086e7a540b1a27b757b9168424b52',
     armv7l: '1461554706deed2492e3b07ce9bca2d2902086e7a540b1a27b757b9168424b52',
     x86_64: '370e17e06126bda39c3d9ef3e44d1ee57f31bdf42198dd281a257db0afb827d9'
  })

  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'lcms'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'libpaper'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'openjpeg'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
