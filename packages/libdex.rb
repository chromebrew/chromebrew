# Adapted from Arch Linux libdex PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libdex

require 'buildsystems/meson'

class Libdex < Meson
  description 'Future-based programming for GLib-based applications and libraries'
  homepage 'https://gitlab.gnome.org/GNOME/libdex'
  version '0.11.1'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libdex.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd7b5ca965600b3a23c38a3e82d869b4966923bb1beed186254c540296078e0d',
     armv7l: 'dd7b5ca965600b3a23c38a3e82d869b4966923bb1beed186254c540296078e0d',
     x86_64: '0a1d0910dd6dcdcf3649c5358e34bf2adb0870deca9599f847950deb2cb55ebf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  meson_options '-Dexamples=false -Dintrospection=disabled -Dtests=false'
end
