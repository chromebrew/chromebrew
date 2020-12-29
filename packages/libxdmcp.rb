require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.3-1'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.3.tar.bz2'
  source_sha256 '20523b44aaa513e17c009e873ad7bbc301507a3224c232610ce2e099011c6529'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '8d044dae7bae3290e3189d25216df2dec946bf3214812c3327f44c5d4af908c7',
      armv7l: '8d044dae7bae3290e3189d25216df2dec946bf3214812c3327f44c5d4af908c7',
        i686: '0bb28f04ed3c6668febc1f9aad001ff0b39ed1746e0ca808bdfbc795bc36cd83',
      x86_64: 'e85f069e15080182742ef6a4cc15742c94ea438ccd2ee772feea199a7fad1622',
  })

  depends_on "xorg_proto"
  depends_on "llvm" => ':build'

  def self.build
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
