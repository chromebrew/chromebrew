require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.3-0'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.3.tar.bz2'
  source_sha256 '20523b44aaa513e17c009e873ad7bbc301507a3224c232610ce2e099011c6529'

  depends_on "xorg_proto"
  depends_on "llvm" => ':build'

  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
