require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.4.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  source_sha256 '7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f784635c565a41eaf08db4642380bfdca20475162aa9cb618cbe2dbc3d28735',
     armv7l: '3f784635c565a41eaf08db4642380bfdca20475162aa9cb618cbe2dbc3d28735',
       i686: 'a9cf7e10199a2ef329b39d5b15118e0cda2a27876bd31f2438010335116b3bfe',
     x86_64: 'e1cf690b2a42be06b5d85d40cbf1fede1b1f15a70f783578742e38bd2f3b2c23'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' # R
  depends_on 'zstd' # R

  no_patchelf

  run_tests
end
