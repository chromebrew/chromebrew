require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '7.1.0'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch/archive/7.1.0.tar.gz'
  source_sha256 '58a95e6b714e41efc804eca389a223309169b2def35e57fa934482a6b47c27e7'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
