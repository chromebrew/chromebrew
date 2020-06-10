require 'package'

class Potrace < Package
  description 'Potrace(TM) is a tool for tracing a bitmap, which means, transforming a bitmap into a smooth, scalable image.'
  homepage 'http://potrace.sourceforge.net/'
  version '1.15'
  compatibility 'all'
  source_url 'http://potrace.sourceforge.net/download/1.15/potrace-1.15.tar.gz'
  source_sha256 'a9b33904ace328340c850a01458199e0064e03ccaaa731bc869a842b1b8d529d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/potrace-1.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/potrace-1.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/potrace-1.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/potrace-1.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8429fae5e3917cb36772db6e14a5245cbf2c1fab7c4798319aace9f037285aed',
     armv7l: '8429fae5e3917cb36772db6e14a5245cbf2c1fab7c4798319aace9f037285aed',
       i686: '24bdf26db8e31189bd7440707bc5372952e6e3d37e3a1cac7220e7c75bde5eaa',
     x86_64: '3afcffc9b2d9db5e880ce55119de7e67295d599ef8fc7837a446f18c67f5ca31',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
