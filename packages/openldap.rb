require 'package'

class Openldap < Package
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.5'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '2e27a8d4f4c2af8fe840b573271c20aa163e24987f9765214644290f5beb38d9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.5_armv7l/openldap-2.6.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.5_armv7l/openldap-2.6.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.5_i686/openldap-2.6.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.5_x86_64/openldap-2.6.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '781f2fda0ed60b38d3c8ff065489e603e8d4cdab667ae4b7abcfce7038c67b35',
     armv7l: '781f2fda0ed60b38d3c8ff065489e603e8d4cdab667ae4b7abcfce7038c67b35',
       i686: '24ca397b5b1c03444022e59ac2cfd8a8ff027590312aab32236360bee38e86bf',
     x86_64: '459f1d99ac6d8826418fe6403053d6f384453a84af675033e75625736e3680a4'
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
