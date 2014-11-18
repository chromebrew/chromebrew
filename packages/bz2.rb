require 'package'

class Bz2 < Package
  version '1.4.17'
  source_url 'http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz'
  source_sha1 '3f89f861209ce81a6bab1fd1998c0ef311712002'

  def self.build
    system "make -f Makefile-libbz2_so"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
  end
end
