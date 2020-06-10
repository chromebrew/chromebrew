require 'package'

class Putty < Package
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.70'
  compatibility 'all'
  source_url 'https://the.earth.li/~sgtatham/putty/latest/putty-0.70.tar.gz'
  source_sha256 'bb8aa49d6e96c5a8e18a057f3150a1695ed99a24eef699e783651d1f24e7b0be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/putty-0.70-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/putty-0.70-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/putty-0.70-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/putty-0.70-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c12ee34ea177bc3b03e4684100246cc0d5a3553a68622c88b1aeff3cea141d9',
     armv7l: '5c12ee34ea177bc3b03e4684100246cc0d5a3553a68622c88b1aeff3cea141d9',
       i686: '49b86933fe7a26d4c5cd211ef117a21a7d5262b99973d1cacd8fa8e563504370',
     x86_64: 'f52110b94240f1cf02eace40fd962d58084fb8ce13970387a658548fbf56a366',
  })

  def self.build
    system './configure --without-gtk'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
