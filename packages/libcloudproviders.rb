# Adapted from Arch Linux libcloudproviders PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcloudproviders/trunk/PKGBUILD

require 'buildsystems/meson'

class Libcloudproviders < Meson
  description 'DBus API that allows cloud storage sync clients to expose their services'
  homepage 'https://gitlab.gnome.org/World/libcloudproviders'
  version '0.3.5'
  license 'LGPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/World/libcloudproviders.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9a4ff7d6ace1b54ade9ebe356a05db1ac254500b846b5347bc1753b97118d99',
     armv7l: 'd9a4ff7d6ace1b54ade9ebe356a05db1ac254500b846b5347bc1753b97118d99',
     x86_64: '0b14369dd46f6997e12692da3305f384b187622a4b5ce4a9eaa407513f8bd5a0'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
