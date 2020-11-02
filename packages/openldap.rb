require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.4.55'
  compatibility 'all'
  source_url 'https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.55.tgz'
  source_sha256 '97357bd6ba8ff73d204c1f8208c5e6ab97d60c9e779f989057aa1229bbe98434'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '74dc2829acce8fdcbe7311e891cce3289023a78bca8989bec31af67094d9108b',
     armv7l: '74dc2829acce8fdcbe7311e891cce3289023a78bca8989bec31af67094d9108b',
       i686: '9015aa6b9ac67d7ad468ca39785a178a53a4aa71542b09529ab0708541086ecf',
     x86_64: '9a98e25d5591422be9810c8fc61a58914dacaca6a99bee842ed2347a3364ca57',
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
