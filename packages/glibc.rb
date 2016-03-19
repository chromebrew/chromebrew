require 'package'

class Glibc < Package
  version '2.9'
  source_url 'http://ftp.gnu.org/gnu/glibc/glibc-2.9.tar.gz'
  source_sha1 '3f0f2b42dfba01649d524adea7761c0974566048'
  
  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
