require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.4.48'
  compatibility 'all'
  source_url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.48.tgz'
  source_sha256 'd9523ffcab5cd14b709fcf3cb4d04e8bc76bb8970113255f372bc74954c6074d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.48-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.48-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.48-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.48-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3114faa85e552c365ebf8956ab443d2c9d6908afd87df1ee51babc82c1a36332',
     armv7l: '3114faa85e552c365ebf8956ab443d2c9d6908afd87df1ee51babc82c1a36332',
       i686: 'b3926bcf814981ac31a2e0d6b9a392ab46760edbaae6aaa0f760b2b29f2fe61a',
     x86_64: 'b666c84259fd202178018520f2b9bd4d657ea2e18c85c62836b9f1ba8a222158',
  })

  depends_on 'libcyrussasl'

  def self.build
    system './configure',
           "--build=#{CREW_BUILD}",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-slapd'
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
