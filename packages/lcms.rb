require 'package'

class Lcms < Package
  description 'Little CMS intends to be an OPEN SOURCE small-footprint color management engine, with special focus on accuracy and performance.'
  homepage 'http://www.littlecms.com/'
  @_ver = '2.12'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/mm2/Little-CMS/releases/download/lcms#{@_ver}/lcms2-#{@_ver}.tar.gz"
  source_sha256 '18663985e864100455ac3e507625c438c3710354d85e5cbb7cd4043e11fe10f5'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/lcms-2.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/lcms-2.12-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/lcms-2.12-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/lcms-2.12-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9cad876e65a97e351278154858ae68200828b01f0d93330b821ecf53d5b31ad5',
     armv7l: '9cad876e65a97e351278154858ae68200828b01f0d93330b821ecf53d5b31ad5',
       i686: '262396399c146e50ad5b38725355bb301f3db2f6beddeaea041f962bfdae9907',
     x86_64: '8fba4add85dcbdd7498a64c065579a7c3625914c437f8ffe363c15cd3b8d67bb'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
