require 'package'

class Libxxf86dga < Package
  description 'X.org the client library for the XFree86-DGA extension'
  homepage 'http://www.x.org'
  version '1.1-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXxf86dga-1.1.tar.gz'
  source_sha256 'b3b7eab9b0b55d41526a5abf9a0b4e104cf2114e6b8adf7c7807b92e848c7d73'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86dga-1.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7640083a2883a0e14b77add34fb9dbaf3d7c941526d31485f38e89b0ce8f9f6b',
     armv7l: '7640083a2883a0e14b77add34fb9dbaf3d7c941526d31485f38e89b0ce8f9f6b',
       i686: '74ec3a332764fc434cdbfb2892da93b7b4aad159478b631f340414258d6da540',
     x86_64: 'b744b0b6d078a6bed7c71e903c652f17fdf7fd5bb0b84cecae9c475a8e845401',
  })

  depends_on 'libxext'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
