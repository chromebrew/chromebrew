require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.5.4'
  version @_ver
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 '61c03c078d70cd859e504fa9555d7d52426eed4b29e6a39e828afc213e4fb356'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.4_armv7l/openldap-2.5.4-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.4_armv7l/openldap-2.5.4-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.4_i686/openldap-2.5.4-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.4_x86_64/openldap-2.5.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f4f36cd3dd5cd5a2056ce11ab0ff8cd750308102f7f7b39eb273c402062e822d',
    armv7l: 'f4f36cd3dd5cd5a2056ce11ab0ff8cd750308102f7f7b39eb273c402062e822d',
    i686: 'd4afb85b12d85a1883b339691f2fa9c29631621094dec2b5a9dc58b3f892761b',
    x86_64: 'e9bbc0ecbc9972b523150ad6c48fffdee3ee9c6e39ce4d154d5d42c43c178e1a'
  })

  depends_on 'libcyrussasl'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} --disable-slapd"
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
