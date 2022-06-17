require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.6.1'
  version @_ver
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 '9d576ea6962d7db8a2e2808574e8c257c15aef55f403a1fb5a0faf35de70e6f3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.1_armv7l/openldap-2.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.1_armv7l/openldap-2.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.1_i686/openldap-2.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.1_x86_64/openldap-2.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6b3a8709e772c271933bfe76cc79aa7c6a73319358c48857dc4d3a53d1cabd7d',
     armv7l: '6b3a8709e772c271933bfe76cc79aa7c6a73319358c48857dc4d3a53d1cabd7d',
       i686: '25415a5c55504a205f7c1768d5e12b5c7278c70e56f3bd77c3e5d103f8da6517',
     x86_64: '4549a1d764ad469b8bffaba66bb291d68ba7bd20deeb8b8b286bc65f825d71a9'
  })

  depends_on 'libcyrussasl' # R
  depends_on 'krb5' # R
  depends_on 'e2fsprogs' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' # R

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
