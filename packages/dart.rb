require 'package'

class Dart < Package
  version '4.4.0.148'

    source_url ({
    i686: "https://www.dropbox.com/s/d1omw087ilkh5oq/jdk1.8.0_25_i686.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/ykw2jt797cpghfy/jdk1.8.0_65_x86_64.tar.gz?dl=0"
  })
  source_sha1 ({
    i686: "2f6fabc6e7b86fa2f21d19f9617d2641c5862a30",
    x86_64: "7701c06a704722b73bf8468a9d7819693e6d4be0"
  })


  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","prefix=#{CREW_DEST_DIR}/usr/local"
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
  end
end