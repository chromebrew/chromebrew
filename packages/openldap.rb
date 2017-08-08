require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'http://www.openldap.org/'
  version '2.4.45'
  source_url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz'
  source_sha256 'cdd6cffdebcd95161a73305ec13fc7a78e9707b46ca9f84fb897cd5626df3824'

  def self.build
    system "./configure --disable-slapd --prefix=/usr/local"
    system "make"
    system "make depend"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
