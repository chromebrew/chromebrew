require 'package'

class Ffcall < Package
  description 'GNU libffcall is a library which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'https://www.gnu.org/software/libffcall/'
  version '2.0'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/libffcall/libffcall-2.0.tar.gz'
  source_sha256 '41aad2b449d90a5308e72267829db006dc9f9cc8736807082e1f2daef680196c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
     armv7l: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
       i686: 'a48db57667d8867fa0566372c4177711fd6532199b416ac6874e4a82d1310ad0',
     x86_64: '6f0395b9c855cc827bdc35ca351a4dc8367c42a601972b6b6986f7d8cd6277a5',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} CFLAGS=\" -fPIC\""
    system 'make', '-j1' # doesn't support parallel builds
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
