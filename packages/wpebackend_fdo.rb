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
    aarch64: '47fb788af30c77c94cf381fc1399b257a8a73da21bce93d2f1b643e43f4107fb',
     armv7l: '47fb788af30c77c94cf381fc1399b257a8a73da21bce93d2f1b643e43f4107fb',
     x86_64: '0ec402f80cfe95578025405e275162569f10b0ed3546627cd3c859ea40567722'
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
