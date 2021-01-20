require 'package'

class Libxext < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXext-1.3.4.tar.gz'
  source_sha256 '8ef0789f282826661ff40a8eef22430378516ac580167da35cc948be9041aac1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxext-1.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '71402bff06db86bd9b08030c7615868a8bfcf3ed52ef9369d066267c1827c118',
     armv7l: '71402bff06db86bd9b08030c7615868a8bfcf3ed52ef9369d066267c1827c118',
       i686: '1aee8625004cb1872da572c6ca962717d421c8245e2c79c418425c86babd1cab',
     x86_64: '9024bf186472eeb3ed2fe0ea7c77716f76c9860248418d8f804f600d5b5c2704',
  })

  depends_on 'llvm' => ':build'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
