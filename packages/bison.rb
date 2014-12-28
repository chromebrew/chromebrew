require 'package'

class Bison < Package
  version '3.0.2'
  source_url 'http://mirror.keystealth.org/gnu/bison/bison-3.0.2.tar.gz'
  source_sha1 '4bbb9a1bdc7e4328eb4e6ef2479b3fe15cc49e54'

  depends_on 'm4'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
