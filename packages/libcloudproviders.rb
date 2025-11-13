# Adapted from Arch Linux libcloudproviders PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcloudproviders/trunk/PKGBUILD

require 'buildsystems/meson'

class Libcloudproviders < Meson
  description 'DBus API that allows cloud storage sync clients to expose their services'
  homepage 'https://gitlab.gnome.org/World/libcloudproviders'
  version '0.3.6'
  license 'LGPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/libcloudproviders.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f68e3b93a7c199be892c61ca4d9cc0e62ff673b61c79ad4e3110d6d898963ee',
     armv7l: '2f68e3b93a7c199be892c61ca4d9cc0e62ff673b61c79ad4e3110d6d898963ee',
     x86_64: 'f97c3dbca6958049f901202f3615ff5b3da0aaf9c46a2f9184ae5e20e6f59f21'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
