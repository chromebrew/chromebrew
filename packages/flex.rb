require 'package'

class Flex < Package
  version '2.5.39'
  source_url 'http://fossies.org/linux/misc/flex-2.6.0.tar.gz'
  source_sha1 'cfe10b5de4893ced356adc437e78018e715818c3'

  depends_on 'm4'
  depends_on 'bison'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
