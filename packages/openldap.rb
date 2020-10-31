require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.4.55'
  compatibility 'all'
  source_url 'https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.55.tgz'
  source_sha256 '97357bd6ba8ff73d204c1f8208c5e6ab97d60c9e779f989057aa1229bbe98434'

  binary_url ({
  })
  binary_sha256 ({
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
