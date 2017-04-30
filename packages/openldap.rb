require 'package'

class Openldap < Package
    version '2.4.44'
    source_url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.44.tgz'
    source_sha1 '016a738d050a68d388602a74b5e991035cdba149'

    def self.build
      system "./configure --disable-slapd --prefix=/usr/local"
      system "make"
      system "make depend"
    end

    def self.install
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
end
