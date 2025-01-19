require 'buildsystems/autotools'

class Lzip < Autotools
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.25'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/lzip/lzip-#{version}.tar.gz"
  source_sha256 'd42659229b10e066eeb6e81eb673cdd893b672e512d26719c2d95975556ca56c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a94eac6bb096a826e3a492989a37ed3dadc8476bb6f83d908331dc80d1dee416',
     armv7l: 'a94eac6bb096a826e3a492989a37ed3dadc8476bb6f83d908331dc80d1dee416',
       i686: '1f161ed81eea70d22a37ab7306e6366e3b661710654cace96f73c6cfc9ce49e3',
     x86_64: 'f9e9a6ea29a9bdfafb24c5eb5ca72e60ac8b6470ecec545a647667bc84630204'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
