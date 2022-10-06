# Adapted from Arch Linux libgxps PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgxps/trunk/PKGBUILD

require 'package'

class Libgxps < Package
  description 'XPS Documents library'
  homepage 'https://wiki.gnome.org/Projects/libgxps'
  @_ver = '0.3.2'
  version "#{@_ver}-1"
  license 'GPL2'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libgxps/-/archive/#{@_ver}/libgxps-#{@_ver}.tar.bz2"
  source_sha256 'ffbc656e801233a64ea5b6ab5532691e8b91f72cce3ea957615fe8523696d42a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgxps/0.3.2-1_armv7l/libgxps-0.3.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgxps/0.3.2-1_armv7l/libgxps-0.3.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgxps/0.3.2-1_i686/libgxps-0.3.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgxps/0.3.2-1_x86_64/libgxps-0.3.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b66e2b7334eec0ddc7061deaeb7d36b48a24bd2b2cb8f9343cacc7788bc7dc3d',
     armv7l: 'b66e2b7334eec0ddc7061deaeb7d36b48a24bd2b2cb8f9343cacc7788bc7dc3d',
       i686: '6c1cac1aaa4f0eec41867f335c93b6a5fe39aaa009b318bec14c6c7a8d2592a4',
     x86_64: '9cbdfadd27b0fad97bbf2c9dd76a0788e738733cc789ca94b74087b1d1fa97df'
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
