require 'package'

class Gambit < Package
  description 'Efficient implementation of the Scheme programming language'
  homepage 'http://gambitscheme.org/wiki/index.php/Main_Page'
  version '4.9.3'
  source_url 'https://github.com/gambit/gambit/archive/v4.9.3.tar.gz'
  source_sha256 'a5e4e5c66a99b6039fa7ee3741ac80f3f6c4cff47dc9e0ff1692ae73e13751ca'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}/gambit",
             '--enable-gcc-opts',
             '--enable-single-host',
             '--enable-openssl',
             '--enable-interpreter-name=gsi-gambit',
             '--enable-compiler-name=gsc-gambit'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
