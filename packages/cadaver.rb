require 'buildsystems/autotools'

class Cadaver < Autotools
  description 'cadaver is a command-line WebDAV client for Unix. It supports file upload, download, on-screen display, namespace operations (move/copy), collection creation and deletion, and locking operations.'
  homepage 'https://notroj.github.io/cadaver/'
  version '0.28'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://notroj.github.io/cadaver/cadaver-#{version}.tar.gz"
  source_sha256 '33e3a54bd54b1eb325b48316a7cacc24047c533ef88e6ef98b88dfbb60e12734'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7425c9c01ecb86b4727cc376aa1602c1a8e31903bbe5bad40d92c1d329a955a9',
     armv7l: '7425c9c01ecb86b4727cc376aa1602c1a8e31903bbe5bad40d92c1d329a955a9',
     x86_64: '01dd4554d018cc3d030f3837b4f46dab148a28d5cc07c0202b6fe62cd746d236'
  })

  depends_on 'expat' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'krb5' => :executable
  depends_on 'libproxy' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'neon' => :executable
  depends_on 'openssl' => :executable
  depends_on 'readline' => :executable
  depends_on 'zlib' => :executable

  autotools_skip_autoreconf
end
