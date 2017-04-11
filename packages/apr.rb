require 'package'

class Apr < Package
    version '1.5.2'
    source_url 'http://apache.claz.org//apr/apr-1.5.2.tar.bz2'
    source_sha1 '6d757fcf7c687fc300c1066076f2e8380ff8cbc0'

    depends_on 'buildessential'

    def self.build
        system './configure --prefix=/usr/local'
        system 'make'
    end

    def self.install
        system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
end
