require 'package'

class Flex < Package
  version '2.6.3'
  source_url 'https://fossies.org/linux/misc/flex-2.6.3.tar.gz'
  source_sha1 '8008eb0e4ccc634c334ac1d9e04716be2ba527a9'

  depends_on 'm4'
  depends_on 'bison'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
