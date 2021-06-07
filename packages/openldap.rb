require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.5.5'
  version "#{@_ver}-1"
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 '74ecefda2afc0e054d2c7dc29166be6587fa9de7a4087a80183bc9c719dbf6b3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5-1_armv7l/openldap-2.5.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5-1_armv7l/openldap-2.5.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5-1_i686/openldap-2.5.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.5.5-1_x86_64/openldap-2.5.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fb6fd0f0690103b39b71bce3a71426feb41ac8f0de03466a2a5985dcd82a4fdd',
     armv7l: 'fb6fd0f0690103b39b71bce3a71426feb41ac8f0de03466a2a5985dcd82a4fdd',
       i686: '409d75a7523e4de951285a5f9daf0d14166467242ce37cf85b5718a85e63cc88',
     x86_64: 'a79aa7779fe182d0e529099f704a7c3d9e590b103d33e2f35779e59c4b582e06'
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
