require 'package'

class Dri2proto < Package
  description ''
  homepage ''
  version '2.8'
  source_url 'https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz'
  source_sha256 '7e65b031eaa6ebe23c75583d4abd993ded7add8009b4200a4db7aa10728b0f61'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
