require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '6.0.0'
  source_url 'https://github.com/dylanaraps/neofetch/archive/6.0.0.tar.gz'
  source_sha256 '264a7689561bb498f97f10231959bdd8f7c873671bac2ffb660de9a5863b1c76'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
