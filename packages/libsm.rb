require 'buildsystems/autotools'

class Libsm < Autotools
  description 'X.org X Session Management Library'
  homepage 'http://www.x.org'
  version '1.2.4-5edd20b'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libsm.git'
  git_hashtag '5edd20b307ce70ccb14c360f1b94914c49544a24'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bddd0de07a4a833a9b6ae2238eb549f5f012f6dfc0a79062551f39ca02c5ec8',
     armv7l: '0bddd0de07a4a833a9b6ae2238eb549f5f012f6dfc0a79062551f39ca02c5ec8',
     x86_64: '3177c18fbb37de01bb93cab3ee821a50987034e5fa146a48e6eb581ebb8cf773'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libx11' => :build
  depends_on 'libxtrans' => :build
  depends_on 'util_linux' # R
end
