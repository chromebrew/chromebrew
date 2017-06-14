require 'package'

class Libfrei0r < Package
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '1.6.0'
  source_url 'https://github.com/dyne/frei0r/archive/v1.6.0.tar.gz'
  source_sha1 'a8214add5828e20ff49239ed3a462acaa8c1ebb2'

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
