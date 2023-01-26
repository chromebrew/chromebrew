require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  @_ver = '2.6.3'
  version @_ver
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{@_ver}.tgz"
  source_sha256 'd2a2a1d71df3d77396b1c16ad7502e674df446e06072b0e5a4e941c3d06c0d46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.3_armv7l/openldap-2.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.3_armv7l/openldap-2.6.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.3_i686/openldap-2.6.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.3_x86_64/openldap-2.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e33440e146ed109636f46a3f5cf05db4798e6b16905f0335fdffd7a9f2f0f135',
     armv7l: 'e33440e146ed109636f46a3f5cf05db4798e6b16905f0335fdffd7a9f2f0f135',
       i686: '2a63e953489dc70695b841afca334218754cc883a018ef68b08f6861247cbef9',
     x86_64: '2a2aa9b72b4a9c6f5503e388372d1a6af4b3b389ae5f9bc506df6d0afd1b0fdb'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' # R
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
