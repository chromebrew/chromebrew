require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '2018.04.16-0'
  source_url 'https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2018.04.16-0.tar.bz2'
  source_sha256 'f11071e74b0c0753f4afabf024941a5c3a96bafe3879211ebd47bc34e76fbd2f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'aspell'

  def self.build
    system "./configure --vars PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system "make", "install"
  end
end
