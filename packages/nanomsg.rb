require 'package'

class Nanomsg < Package
  version '1.0,0'
  source_url 'https://github.com/nanomsg/nanomsg/archive/1.0.0.tar.gz'
  source_sha1 '57f90778a9bb7b95a7fd73910fd41894f3ee9cab'

  depends_on 'cmake'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
