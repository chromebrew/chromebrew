require 'buildsystems/meson'

class Wpebackend_fdo < Meson
  description 'Freedesktop.org backend for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.16.0'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Igalia/WPEBackend-fdo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bf04acd2a0086a4dfd8376829577d00de7366cd4304383d65bf2226d05449de',
     armv7l: '8bf04acd2a0086a4dfd8376829577d00de7366cd4304383d65bf2226d05449de',
     x86_64: '2f878e911a8b013af12f05680f5c894b1e23b5c04301a8d936ff55993387a6c4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libepoxy'
  depends_on 'libwpe' # R
  depends_on 'mesa' => :build
  depends_on 'wayland'
  depends_on 'wayland_protocols' => :build

end
