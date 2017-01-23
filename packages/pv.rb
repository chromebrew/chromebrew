require 'package'

class Pv < Package
  version '1.6.0'
  source_url 'http://www.ivarch.com/programs/sources/pv-1.6.0.tar.gz'
  source_sha1 '395ce62f4f3e035b86c77038f04b96c5aa233595'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
