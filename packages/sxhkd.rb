require 'buildsystems/autotools'

class Sxhkd < Autotools
  description 'Simple X HotKey Daemon'
  homepage 'https://github.com/baskerville/sxhkd'
  version '0.6.3'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/baskerville/sxhkd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a2f474b4bb54024dec326a996118d66c09ff43534262155acd24dfd95682694',
     armv7l: '0a2f474b4bb54024dec326a996118d66c09ff43534262155acd24dfd95682694',
       i686: 'e4e8b0fd8d2b82a53882130e21f0f56601df4efbf16ce7f1320a4e562fd85db0',
     x86_64: '75332a8ba73f04792c941538e9ed85d863b56156d0ab84c5e446a3ecd1c52c6d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'xcb_util' => :executable
  depends_on 'xcb_util_keysyms' => :executable

  autotools_skip_configure
end
