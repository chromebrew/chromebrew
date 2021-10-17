require 'package'

class Plzip < Package
  description 'Plzip is a massively parallel (multi-threaded) drop-in implementation of lzip.'
  homepage 'https://www.nongnu.org/lzip/plzip.html'
  version '1.9'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.9.tar.gz'
  source_sha256 '14d8d1db8dde76bdd9060b59d50b2943417eb4c0fbd2b84736546b78fab5f1a7'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plzip/1.9_armv7l/plzip-1.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plzip/1.9_armv7l/plzip-1.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plzip/1.9_i686/plzip-1.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plzip/1.9_x86_64/plzip-1.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c3fee5fe9f16a2dd68a9835a1450c128fc2b1a95ac652969e665dbdd47155f6d',
     armv7l: 'c3fee5fe9f16a2dd68a9835a1450c128fc2b1a95ac652969e665dbdd47155f6d',
       i686: 'fe794554700f27d08f76a6c5d964d3661f5f280a0b005a596c7d835a262e72f1',
     x86_64: '32e84b9436c86136bf9e872e46a4370b56e735c5e343a861ae875195f410ff95',
  })

  depends_on 'lzlib' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              CXX=#{CREW_TGT}-g++ \
              CXXFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
