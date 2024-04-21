require 'buildsystems/autotools'

class Mhash < Autotools
  description 'Mhash is a free (under GNU Lesser GPL) library which provides a uniform interface to a large number of hash algorithms.'
  homepage 'https://mhash.sourceforge.net/'
  version '0.9.9.9'
  license 'LGPLv2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.bz2'
  source_sha256 '56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab248dfef0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae5cde52b8d93b956ef6bc634c3e8a12821534fc5dfc83a145a0a4ffd264e720',
     armv7l: 'ae5cde52b8d93b956ef6bc634c3e8a12821534fc5dfc83a145a0a4ffd264e720',
       i686: '1faf6e2dc281564034e6325b8a3ea7eddb978610117fdb3ab1bb374c63a9d1ec',
     x86_64: 'd97e86742b4b9c4b5cbbf1423bc36a2d9ef1ebaa5b630494ee1c0a6940bf2cd1'
  })

  depends_on 'glibc' # R

  run_tests
end
