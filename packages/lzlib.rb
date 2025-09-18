require 'buildsystems/autotools'

class Lzlib < Autotools
  description 'Lzlib is a data compression library providing in-memory LZMA compression and decompression functions, including integrity checking of the decompressed data.'
  homepage 'https://www.nongnu.org/lzip/lzlib.html'
  version '1.15'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-#{version}.tar.lz"
  source_sha256 '9d45480e7c8171c64fa1d5beee2cbd82e69febe910f0ce628b876a8fe2141534'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc13166eba5e32b86836347ea9923ef62d34489c5f89f1a093977d1e02c61801',
     armv7l: 'fc13166eba5e32b86836347ea9923ef62d34489c5f89f1a093977d1e02c61801',
       i686: 'bf5968309ce44780c499385b87eb3d69cc879fca19753415aaadedbc6e8e8336',
     x86_64: '9058118a384e5ee7064d4a55981b722a5b3befd6b8fac16c66f052fdd6a14ef6'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared'
end
