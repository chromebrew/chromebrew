require 'buildsystems/meson'

class Libgudev < Meson
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '238'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgudev.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/238_armv7l/libgudev-238-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/238_armv7l/libgudev-238-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgudev/238_x86_64/libgudev-238-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '90a6e1e31605c0e70bb19a9670f6d63b386c32c8a5e19d7b8b3fc6bec48990ba',
     armv7l: '90a6e1e31605c0e70bb19a9670f6d63b386c32c8a5e19d7b8b3fc6bec48990ba',
     x86_64: '3c4e94e7cf0a94d58929a3a2f2b722a701070424750ebdb70793039345eb00bc'
  })

  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
end
