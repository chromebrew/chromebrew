require 'package'

class Rush < Package
  description 'GNU Rush is a Restricted User Shell.'
  homepage 'https://www.gnu.org/software/rush/'
  version '2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/rush/rush-2.1.tar.xz'
  source_sha256 'c2ff487d44ce3d14854d0269eb0aa4c0f98bcca35390fad5ea52da75d9e4abdf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
  def self.check
    system "make", "check"
  end
end
