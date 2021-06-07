require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.5.5'
  version @_ver
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 '74ecefda2afc0e054d2c7dc29166be6587fa9de7a4087a80183bc9c719dbf6b3'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5_armv7l/openldap-2.5.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5_armv7l/openldap-2.5.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5_i686/openldap-2.5.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5_x86_64/openldap-2.5.5-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '790797260a558e03e4535274f5fa3166c603ef758e51f57d171bcf8580de8e17',
     armv7l: '790797260a558e03e4535274f5fa3166c603ef758e51f57d171bcf8580de8e17',
       i686: 'f02b2011b521f10fc363c114e2302812c34f6c55a0cb476dec18eb323f6d8826',
     x86_64: '04f71709113fd814c9d2c36ec23fdb329c8d2325bc013f13e8044a36b785e289',
  })

  depends_on 'libcyrussasl'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS} --disable-slapd"
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
