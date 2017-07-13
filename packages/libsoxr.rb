require 'package'

class Libsoxr < Package
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.2'
  source_url 'https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz'
  source_sha256 '54e6f434f1c491388cd92f0e3c47f1ade082cc24327bdc43762f7d1eefe0c275'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
