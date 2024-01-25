require 'package'

class Lzlib < Package
  description 'Lzlib is a data compression library providing in-memory LZMA compression and decompression functions, including integrity checking of the decompressed data.'
  homepage 'https://www.nongnu.org/lzip/lzlib.html'
  version '1.13'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.lz'
  source_sha256 'dde6bd5b32535f17b28c9ac24b66607e0250506ac1432a4112ca3c73f5d662c3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46a6b8e451aba864ef2fea40b97288fa04a3cf69a90bfe0aed5a6d3eaa4bc33e',
     armv7l: '46a6b8e451aba864ef2fea40b97288fa04a3cf69a90bfe0aed5a6d3eaa4bc33e',
       i686: 'b6735c811d2dae672ad0309071f3563aa4ebcf0f3956c6d721955ae0b5c9f687',
     x86_64: '87e3ac042df3ab14d50fe64d548a28ed9bd59cb36a4720345eaaa2a802970934'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-shared"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
