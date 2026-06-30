require 'buildsystems/meson'

class Libgudev < Meson
  description 'libgudev is a library with GObject bindings to libudev'
  homepage 'https://wiki.gnome.org/Projects/libgudev'
  version '238'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libgudev.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90a6e1e31605c0e70bb19a9670f6d63b386c32c8a5e19d7b8b3fc6bec48990ba',
     armv7l: '90a6e1e31605c0e70bb19a9670f6d63b386c32c8a5e19d7b8b3fc6bec48990ba',
       i686: '0a28e242706ef58aba8a621a13c5e9c64c840bc048204e4eb27a812c199aaf02',
     x86_64: '3c4e94e7cf0a94d58929a3a2f2b722a701070424750ebdb70793039345eb00bc'
  })

  depends_on 'eudev' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
end
