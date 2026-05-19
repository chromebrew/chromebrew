require 'buildsystems/autotools'

class Flac < Autotools
  description 'FLAC stands for Free Lossless Audio Codec, an audio format similar to MP3, but lossless, meaning that audio is compressed in FLAC without any loss in quality.'
  homepage 'https://xiph.org/flac/'
  version '1.5.0'
  license 'BSD, FDL-1.2, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://downloads.xiph.org/releases/flac/flac-#{version}.tar.xz"
  source_sha256 'f2c1c76592a82ffff8413ba3c4a1299b6c7ab06c734dee03fd88630485c2b920'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dda3a62caf9264003b1cc0c36fe0e2fc3a4b2169166d08d65fe4c54dc9f69c73',
     armv7l: 'dda3a62caf9264003b1cc0c36fe0e2fc3a4b2169166d08d65fe4c54dc9f69c73',
       i686: '6692d780355efbba4b2afdd5a3b229bdd1ef327a5117310675d7afd6e8168ba9',
     x86_64: 'f537e823f2d2045d0c329d802c9e285be32b42bd7f5ed71629f708430b7a7abc'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libogg' => :library

  def self.patch
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i 's,1.16,#{aclocal_version},g' configure"
  end
end
