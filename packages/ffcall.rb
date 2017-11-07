require 'package'

class Ffcall < Package
  description 'GNU libffcall is a library which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'https://www.gnu.org/software/libffcall/'
  version '2.0'
  source_url 'https://ftp.gnu.org/gnu/libffcall/libffcall-2.0.tar.gz'
  source_sha256 '41aad2b449d90a5308e72267829db006dc9f9cc8736807082e1f2daef680196c'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} CFLAGS=\" -fPIC\""
    system 'make', '-j1' # doesn't support parallel builds
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
