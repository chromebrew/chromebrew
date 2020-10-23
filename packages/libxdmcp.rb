require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.3-0'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.3.tar.bz2'
  source_sha256 '20523b44aaa513e17c009e873ad7bbc301507a3224c232610ce2e099011c6529'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef0521827a14d8b96ebebc7b427862a034d9aaf3bcb8a91d87a5210b64e1935f',
     armv7l: 'ef0521827a14d8b96ebebc7b427862a034d9aaf3bcb8a91d87a5210b64e1935f',
       i686: '2bde707c2fa208e763c691f7bd7c3ad79613d15f9a3068a528af5ba9809e26c3',
     x86_64: 'c36427179ecf0ff60f51907008834c588fd533869b05d5487f309ad7235eccfa',
  })

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
