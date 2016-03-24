require 'package'

class Make < Package
  version '3.82'
  source_url 'http://ftp.gnu.org/gnu/make/make-3.82.tar.gz'
  source_sha1 '92d1b87a30d1c9482e52fb4a68e8a355e7946331'

  def self.build
    system "./configure", "--disable-debug", "--disable-dependency-tracking"
    system "CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
