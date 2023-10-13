# Adapted from Arch Linux jsonrpc-glib PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/jsonrpc-glib/trunk/PKGBUILD

require 'package'

class Jsonrpc_glib < Package
  description 'A JSON-RPC library for GLib'
  homepage 'https://gitlab.gnome.org/GNOME/jsonrpc-glib'
  version '3.42.0'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/jsonrpc-glib.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonrpc_glib/3.42.0_armv7l/jsonrpc_glib-3.42.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonrpc_glib/3.42.0_armv7l/jsonrpc_glib-3.42.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonrpc_glib/3.42.0_i686/jsonrpc_glib-3.42.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonrpc_glib/3.42.0_x86_64/jsonrpc_glib-3.42.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3f88e3475e71dd51196732f937c0cc9c814b541a84f2dbf34945cf0b37477eec',
     armv7l: '3f88e3475e71dd51196732f937c0cc9c814b541a84f2dbf34945cf0b37477eec',
       i686: 'e562c2da3be03430a0d69725dd74dead647243cba16e07f6dd69c7d457f42063',
     x86_64: '19964bdf5d11e2c40c9cd1d09107045b28259e9d657df1bdd6ec31f28b847d86'
  })

  depends_on 'json_glib'
  depends_on 'vala' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.check
    system 'ninja test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
