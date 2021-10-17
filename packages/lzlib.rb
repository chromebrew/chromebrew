require 'package'

class Lzlib < Package
  description 'Lzlib is a data compression library providing in-memory LZMA compression and decompression functions.'
  homepage 'https://www.nongnu.org/lzip/lzlib.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.12.tar.lz'
  source_sha256 '238469af158a5a52e480907014dd90fe8ae5a78070473e18634fb74ac17cfcd8'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzlib/1.12_armv7l/lzlib-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzlib/1.12_armv7l/lzlib-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzlib/1.12_i686/lzlib-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzlib/1.12_x86_64/lzlib-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dbfdffd11780ab0572e021247c54e377cbe32d16a8ef306829f7174c49d3962f',
     armv7l: 'dbfdffd11780ab0572e021247c54e377cbe32d16a8ef306829f7174c49d3962f',
       i686: '25e791b522ddbfd67af4232a02af5579459024714a3ed9f0acb4210b8b3d8672',
     x86_64: '6cae4f66b558db9dbee23e086e896dac89fca1739a63ed0ab26a6eb9f5264784',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            CC=#{CREW_TGT}-gcc \
            CFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
