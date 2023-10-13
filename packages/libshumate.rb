# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'package'

class Libshumate < Package
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.0.1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate/-/archive/1.0.1/libshumate-1.0.1.tar.bz2'
  source_sha256 '004188509189eab352b8f86701cec223c15c8fa52b1e0cf5379877725a1e9014'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libshumate/1.0.1_armv7l/libshumate-1.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libshumate/1.0.1_armv7l/libshumate-1.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libshumate/1.0.1_i686/libshumate-1.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libshumate/1.0.1_x86_64/libshumate-1.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f52fac3cb098d9048580df930016a6fa597e29140eb1680c34d38b98bfd74fb2',
     armv7l: 'f52fac3cb098d9048580df930016a6fa597e29140eb1680c34d38b98bfd74fb2',
       i686: '070e45c5b594a7c8f1e68e4100a456a61301d06781946c96b9fccb1be4851c9f',
     x86_64: '47f61acf76edf10e4e127efe5ba0b3b40781540ce14b5df35a0b28e0d514254d'
  })

  depends_on 'gtk4'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsoup' # R
  depends_on 'sqlite' # R

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
