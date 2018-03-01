require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.1.2'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.1.2.tar.gz'
  source_sha256 '4ce77b6ef538ef090d9bde1d5eeff8b3069ab56c4906f083475517c2c023dfa7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a757e5b3576e636c9b04def1784dab0d54fb2d2b397a8f41f96e973920b5dad',
     armv7l: '5a757e5b3576e636c9b04def1784dab0d54fb2d2b397a8f41f96e973920b5dad',
       i686: '023b8baa817e114c2fa97a5cc0a0e79728d3587c0fd8d385b13d1d5a0994470f',
     x86_64: '218d4224019530780f6b739b4f28e3c3a29d04a0f471f49290961d3956d7d9aa',
  })

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
