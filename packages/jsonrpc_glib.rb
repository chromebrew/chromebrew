# Adapted from Arch Linux jsonrpc-glib PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/jsonrpc-glib/trunk/PKGBUILD

require 'buildsystems/meson'

class Jsonrpc_glib < Meson
  description 'A JSON-RPC library for GLib'
  homepage 'https://gitlab.gnome.org/GNOME/jsonrpc-glib'
  version '3.44.0'
  license 'LGPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/jsonrpc-glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69b27938d61637c9053e7a541485b7b1642b636f91e6c9c9a0dcf42d3dfe841c',
     armv7l: '69b27938d61637c9053e7a541485b7b1642b636f91e6c9c9a0dcf42d3dfe841c',
     x86_64: 'c982f30fa62ce1e7065c130c7d6ef592920e055f919d5d4af38573c5813a7013'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'json_glib' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'vala' => :build

  gnome
end
