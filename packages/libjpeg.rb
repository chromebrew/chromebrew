require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.0-d'
  compatibility 'all'
  source_url 'https://www.ijg.org/files/jpegsrc.v9d.tar.gz'
  source_sha256 '99cb50e48a4556bc571dadd27931955ff458aae32f68c4d9c39d624693f69c32'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-d-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-d-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-d-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-d-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d0248976ed26493bf18231df01cb42eff81792440cf6cb517679b609804a44e',
     armv7l: '1d0248976ed26493bf18231df01cb42eff81792440cf6cb517679b609804a44e',
       i686: '3291fe256b305b2ee3de0fe8d4c455012ba92545ef3bfd155c25d5d86b8977c4',
     x86_64: '6c166e006cbb47be453f41f1e6e6d452df0a6b0b8f3675e29d290f20bfdcf3ef',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
