require 'package'

class Libsoxr < Package
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.2'
  source_url 'https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz'
  source_sha1 '3b990f91dc8dc08e70626cd5fb90deda0239c211'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
