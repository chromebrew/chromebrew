require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'http://www.openldap.org/'
  version '2.4.45'
  source_url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz'
  source_sha256 'cdd6cffdebcd95161a73305ec13fc7a78e9707b46ca9f84fb897cd5626df3824'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.45-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.45-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.45-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.45-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65b8d0db561c4c5732a2a499cd1703a2126ce8debf13abe81de066f3ba968954',
     armv7l: '65b8d0db561c4c5732a2a499cd1703a2126ce8debf13abe81de066f3ba968954',
       i686: '35b5e0d15baf20ccdf0d1f3b0693f4c42742c60ffaec631dc015133abf1272bb',
     x86_64: '89922907122e587d9107cfaa4ce7b0657ff2590507db92d97905096c28170d99',
  })

  def self.build
    system "./configure --disable-slapd --prefix=/usr/local"
    system "make"
    system "make depend"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
