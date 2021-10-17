require 'package'

class Tarlz < Package
  description 'Tarlz is a massively parallel (multi-threaded) combined implementation of the tar archiver and the lzip compressor.'
  homepage 'https://www.nongnu.org/lzip/tarlz.html'
  version '1.21'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.21.tar.lz'
  source_sha256 '0f972112dd3f126a394d5a04107695ccbbb9e603e7b193367bd1714607e0adf4'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tarlz/1.21_armv7l/tarlz-1.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tarlz/1.21_armv7l/tarlz-1.21-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tarlz/1.21_i686/tarlz-1.21-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tarlz/1.21_x86_64/tarlz-1.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6a9a4e5220560396ca4791709cca1ef3a4f6e1cdd4ddedf86f428b6e793895d',
     armv7l: 'c6a9a4e5220560396ca4791709cca1ef3a4f6e1cdd4ddedf86f428b6e793895d',
       i686: '1e8bc762b7cb33ec74c2a5c1584c229889de71b4884f8a176b9576581ca2d8b8',
     x86_64: '9012fb9c95a553b6855168c046ae37cf51a13fdef33ce221c6dfd950cfa617a3',
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
