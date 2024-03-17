# Adapted from Arch Linux jsonrpc-glib PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/jsonrpc-glib/trunk/PKGBUILD

require 'buildsystems/meson'

class Jsonrpc_glib < Meson
  description 'A JSON-RPC library for GLib'
  homepage 'https://gitlab.gnome.org/GNOME/jsonrpc-glib'
  version '3.44.0'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/jsonrpc-glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f88e3475e71dd51196732f937c0cc9c814b541a84f2dbf34945cf0b37477eec',
     armv7l: '3f88e3475e71dd51196732f937c0cc9c814b541a84f2dbf34945cf0b37477eec',
       i686: 'e562c2da3be03430a0d69725dd74dead647243cba16e07f6dd69c7d457f42063',
     x86_64: '19964bdf5d11e2c40c9cd1d09107045b28259e9d657df1bdd6ec31f28b847d86'
  })

  depends_on 'json_glib' => :build
  depends_on 'vala' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
