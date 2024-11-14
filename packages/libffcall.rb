require 'package'

class Libffcall < Package
  description 'GNU libffcall is a library which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'https://www.gnu.org/software/libffcall/'
  version '2.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libffcall/libffcall-2.0.tar.gz'
  source_sha256 '41aad2b449d90a5308e72267829db006dc9f9cc8736807082e1f2daef680196c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
     armv7l: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
       i686: 'a48db57667d8867fa0566372c4177711fd6532199b416ac6874e4a82d1310ad0',
     x86_64: '6f0395b9c855cc827bdc35ca351a4dc8367c42a601972b6b6986f7d8cd6277a5'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} CFLAGS=\" -fPIC\""
    system 'make', '-j1' # doesn't support parallel builds
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
