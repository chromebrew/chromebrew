require 'package'

class Libxfce4util < Package
    description 'Utility library for the Xfce4 desktop environment'
    homepage "https://xfce.org/"
    version '4.14.0'
    compatibility 'all'
    source_url "https://archive.xfce.org/src/xfce/libxfce4util/4.14/libxfce4util-4.14.0.tar.bz2"
    source_sha256 '32ad79b7992ec3fd863e8ff2f03eebda8740363ef9d7d910a35963ac1c1a6324'
    
    depends_on 'libxfce4ui'
    
    def self.build
        system "./configure #{CREW_OPTIONS}"
        system "make -j#{CREW_NPROC}"
    end
    def self.install
        system "make install DESTDIR=#{CREW_DEST_DIR}"
    end
end
