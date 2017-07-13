require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'http://www.openldap.org/'
  version '2.4.44'
  source_url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.44.tgz'
  source_sha256 'd7de6bf3c67009c95525dde3a0212cc110d0a70b92af2af8e3ee800e81b88400'

  def self.build
    system "./configure --disable-slapd --prefix=/usr/local"
    system "make"
    system "make depend"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
