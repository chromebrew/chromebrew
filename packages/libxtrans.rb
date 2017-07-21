require 'package'

class Libxtrans < Package
  description 'transpot library for the X window system'
  homepage 'https://x.org'
  version '1.3.5'
  source_url 'https://www.x.org/archive/individual/lib/xtrans-1.3.5.tar.gz'
  source_sha256 'b7a577c1b6c75030145e53b4793db9c88f9359ac49e7d771d4385d21b3e5945d'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
