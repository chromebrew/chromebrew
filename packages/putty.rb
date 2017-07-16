require 'package'

class Putty < Package
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.70'
  source_url 'https://the.earth.li/~sgtatham/putty/latest/putty-0.70.tar.gz'
  source_sha256 'bb8aa49d6e96c5a8e18a057f3150a1695ed99a24eef699e783651d1f24e7b0be'

  def self.build
    system './configure --without-gtk'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
