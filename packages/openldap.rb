require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.6.4'
  version @_ver
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 'd51704e50178430c06cf3d8aa174da66badf559747a47d920bb54b2d4aa40991'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.4_armv7l/openldap-2.6.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.4_armv7l/openldap-2.6.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.4_i686/openldap-2.6.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.4_x86_64/openldap-2.6.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd7fb060b540a91e103aa4252e5ebaa3d219cb86372277f72e91b8d590c8c7592',
     armv7l: 'd7fb060b540a91e103aa4252e5ebaa3d219cb86372277f72e91b8d590c8c7592',
       i686: '6e4b3f2cb18c7eda1159ef59ef27120406557fc5513ed7edbb49708dfe744bc5',
     x86_64: '1b78e492b4ba7924669f25da5b0a059f001d230bb50f5e614764ee4067ca77ef'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} --disable-slapd"
    system 'make'
    system 'make depend'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
