# Adapted from Arch Linux jsonrpc-glib PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/jsonrpc-glib/trunk/PKGBUILD

require 'buildsystems/meson'

class Jsonrpc_glib < Meson
  description 'A JSON-RPC library for GLib'
  homepage 'https://gitlab.gnome.org/GNOME/jsonrpc-glib'
  version '3.44.2'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/jsonrpc-glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f173283df257cc4799e63f5ac87875dcf927c909e912833b33774cd7022a79ad',
     armv7l: 'f173283df257cc4799e63f5ac87875dcf927c909e912833b33774cd7022a79ad',
     x86_64: '1d1cffe07b9f7b44e8b043c704e5a7eafd86ad8c92c1c8c69bf050987d023e8a'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'json_glib' # R
  depends_on 'py3_gi_docgen' => :build

  gnome

  meson_options '-Dwith_introspection=false -Dwith_vapi=false'
end
