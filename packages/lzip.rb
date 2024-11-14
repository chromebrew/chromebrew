require 'buildsystems/autotools'

class Lzip < Autotools
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.24'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.24.tar.gz'
  source_sha256 'd42659229b10e066eeb6e81eb673cdd893b672e512d26719c2d95975556ca56c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a94eac6bb096a826e3a492989a37ed3dadc8476bb6f83d908331dc80d1dee416',
     armv7l: 'a94eac6bb096a826e3a492989a37ed3dadc8476bb6f83d908331dc80d1dee416',
       i686: '140f40c6ee603c9a559ddbe51446ca59304bbf293d8aada92d5ee14178272a65',
     x86_64: 'a16eac8f2e028504c47a905cd6f62e0b09b193e81e1336c76d74fb985b115330'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
