require 'package'

class Pixman < Package
  version '0.34.0'
  source_url 'https://www.cairographics.org/releases/pixman-0.34.0.tar.gz'
  source_sha1 'a1b1683c1a55acce9d928fea1ab6ceb79142ddc7'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
