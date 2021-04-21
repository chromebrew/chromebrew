require 'package'

class Libxmu < Package
  description 'X.org X interface library for miscellaneous utilities not part of the Xlib standard'
  homepage 'https://www.x.org'
  version '1.1.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXmu-1.1.2.tar.gz'
  source_sha256 'e5fd4bacef068f9509b8226017205040e38d3fba8d2de55037200e7176c13dba'

  binary_url ({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libxmu-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libxmu-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libxmu-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libxmu-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b0e35fa7604228c0bc7e556a3425e928a90f9f00707126c6007c235b9162c75c',
     armv7l: 'b0e35fa7604228c0bc7e556a3425e928a90f9f00707126c6007c235b9162c75c',
       i686: '6780b8d82aa0b43aae9af514546741dcde6758c32ecbafdf0b181aeb74600b47',
     x86_64: '66b75c1f3488973f36f4520fa283f860bdebdea608716a082776e8364a092d4f',
  })

  depends_on 'libxt'
  depends_on 'libxext'
  depends_on 'util_macros'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
