require 'package'

class Socat < Package
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.7.3.1'
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.3.1.tar.gz'
  source_sha256 'a8cb07b12bcd04c98f4ffc1c68b79547f5dd4e23ddccb132940f6d55565c7f79'

  depends_on 'readline'
  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
