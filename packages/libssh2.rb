require 'buildsystems/autotools'

class Libssh2 < Autotools
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://libssh2.org/'
  version '1.11.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://libssh2.org/download/libssh2-#{version}.tar.gz"
  source_sha256 '3736161e41e2693324deb38c26cfdc3efe6209d634ba4258db1cecff6a5ad461'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d155714a8e24c47778bfccdfd3bcaeaa64991c88b6ff0fe9a748d5f5680d852',
     armv7l: '0d155714a8e24c47778bfccdfd3bcaeaa64991c88b6ff0fe9a748d5f5680d852',
       i686: '031b1e4e102b791c9f6b61af75991ed118781a2b1630684731c7a7935519031c',
     x86_64: '4233a506fb5cb1e11ee38fc93649a632c508bdc9cbe6346d99455b096c76fd0e'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options '--with-libz'
end
