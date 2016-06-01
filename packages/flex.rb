require 'package'

class Flex < Package
  version '2.5.39'
  source_url 'http://pkgs.fedoraproject.org/repo/pkgs/flex/flex-2.5.39.tar.bz2/77d44c6bb8c0705e0017ab9a84a1502b/flex-2.5.39.tar.bz2'
  source_sha1 '267794c709d5c50f2dcb48ff5d8dcbbfe40f953e'

  depends_on 'm4'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
