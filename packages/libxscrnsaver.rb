require 'package'

class Libxscrnsaver < Package
  description 'X.org the X11 Screen Saver extension client library'
  homepage 'http://www.x.org'
  version '1.2.2'
  source_url 'https://www.x.org/archive//individual/lib/libXScrnSaver-1.2.2.tar.gz'
  source_sha256 'e12ba814d44f7b58534c0d8521e2d4574f7bf2787da405de4341c3b9f4cc8d96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9e071ec1e54fee2879ed3fd5388f5e510812f0e7593efdeeaa407df96bcec70',
     armv7l: 'e9e071ec1e54fee2879ed3fd5388f5e510812f0e7593efdeeaa407df96bcec70',
       i686: 'df9518c09b515b59d34361ee293d21b8593d5565b0571920503689e2dfa30d1f',
     x86_64: '9c4d17416463a70659c83f143de43a15cd867c3af57c234b882987d79f30a06d',
  })

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'xextproto'
  depends_on 'scrnsaverproto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
