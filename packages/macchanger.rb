require 'package'

class Macchanger < Package
  description 'GNU MAC Changer is an utility that makes the manipulation of MAC addresses of network interfaces easier.'
  homepage 'http://www.gnu.org/software/macchanger/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/alobbs/macchanger/releases/download/1.7.0/macchanger-1.7.0.tar.gz'
  source_sha256 'dae2717c270fd5f62d790dbf80c19793c651b1b26b62c101b82d5fdf25a845bf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/macchanger-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/macchanger-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/macchanger-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/macchanger-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bee8775a633ffd9477709174b0303a5fcb432a9065f81d978580def71fc2a744',
     armv7l: 'bee8775a633ffd9477709174b0303a5fcb432a9065f81d978580def71fc2a744',
       i686: '0b36b17ab360fa74bce415e31404feffc0ba119c1324f2bdd073701a305d11e4',
     x86_64: '954d693d8ccdcb403c0a5d29d17f5119ea3bfa62db1c59f8cf08eb1b5d495f5b',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
