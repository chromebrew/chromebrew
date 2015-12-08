require 'package'

class Flex < Package
  version '2.5.39'
  source_url 'http://fossies.org/linux/misc/flex-2.5.39.tar.gz'
  source_sha1 '40866373afd3ab88a7f7fe26c9b27b035aa1f2a9'

  depends_on 'm4'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
