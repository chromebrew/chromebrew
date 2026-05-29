require 'buildsystems/autotools'

class Lzlib < Autotools
  description 'Lzlib is a data compression library providing in-memory LZMA compression and decompression functions, including integrity checking of the decompressed data.'
  homepage 'https://www.nongnu.org/lzip/lzlib.html'
  version '1.16'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-#{version}.tar.lz"
  source_sha256 'cd2a96fbc685f7e3dc32b9f0e5e34046a77e3c10fcfebe62f9951e317d0a8cf4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc13166eba5e32b86836347ea9923ef62d34489c5f89f1a093977d1e02c61801',
     armv7l: 'fc13166eba5e32b86836347ea9923ef62d34489c5f89f1a093977d1e02c61801',
       i686: 'bf5968309ce44780c499385b87eb3d69cc879fca19753415aaadedbc6e8e8336',
     x86_64: '9058118a384e5ee7064d4a55981b722a5b3befd6b8fac16c66f052fdd6a14ef6'
  })

  depends_on 'glibc' => :library

  autotools_configure_options '--enable-shared'
end
