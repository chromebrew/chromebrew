require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.4.50'
  compatibility 'all'
  source_url 'https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.50.tgz'
  source_sha256 '5cb57d958bf5c55a678c6a0f06821e0e5504d5a92e6a33240841fbca1db586b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0267ada9d7a13d09de9ca7503f1fe6623262de74dd364cb3998e6ae30d583808',
     armv7l: '0267ada9d7a13d09de9ca7503f1fe6623262de74dd364cb3998e6ae30d583808',
       i686: '71df836d0590e3ab3c27b7bc0debac785b112615f2138a5e13e4d901b2b40413',
     x86_64: '1c71f56cdecc230eaa5a5188b4141d71e84e61c77033b7c9f7aa5a0c60799049',
  })

  depends_on 'libcyrussasl'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-slapd"
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
