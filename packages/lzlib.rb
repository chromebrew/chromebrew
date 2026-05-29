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
    aarch64: 'a340034b3d3709d2ac4c5f83bcab5444b05ce32a02fde6bd6bf441df69fbd077',
     armv7l: 'a340034b3d3709d2ac4c5f83bcab5444b05ce32a02fde6bd6bf441df69fbd077',
       i686: 'c67430fa2b3442879e3e75bd75e4abf82dbf6f878cb9a5165118c87085fbfaf1',
     x86_64: '320f566a2f73f877707d584ec37a327923c09bbc16996d18db83caf92973ed15'
  })

  depends_on 'glibc' => :library

  autotools_configure_options '--enable-shared'
end
