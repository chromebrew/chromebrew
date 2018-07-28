require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.5'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.5.tar.xz'
  source_sha256 '7aad73c8839c2bdadca9476f884d2953cdace9567ecd0d90f9959f229d146b40'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a73a70e5436d994a10cade4eb4d2838ea11eefa5840358a184c4dbe57838bbb',
     armv7l: '2a73a70e5436d994a10cade4eb4d2838ea11eefa5840358a184c4dbe57838bbb',
       i686: 'af4cb9eed54543196ffedd805d04646eb01f0106385aa886eabfb86ff04a95a3',
     x86_64: '9539a9e450d9bde9382382c3878d52781f9bf7634e6416b216c44e4f3674d628',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
