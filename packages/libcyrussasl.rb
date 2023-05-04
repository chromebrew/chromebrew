require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.28-1'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.28/cyrus-sasl-2.1.28.tar.gz'
  source_sha256 '7ccfc6abd01ed67c1a0924b353e526f1b766b21f42d4562ee635a8ebfc5bb38c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28-1_armv7l/libcyrussasl-2.1.28-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28-1_armv7l/libcyrussasl-2.1.28-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28-1_i686/libcyrussasl-2.1.28-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28-1_x86_64/libcyrussasl-2.1.28-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9fcab15850eaa1926182c9f5a0184eba152ebe7c11b1d532f88c1b69d58af3d2',
     armv7l: '9fcab15850eaa1926182c9f5a0184eba152ebe7c11b1d532f88c1b69d58af3d2',
       i686: '5dfe33f38a6de869fe1a07ba18bf65f6034cc2958629d297127c1fa5d77dac8d',
     x86_64: 'b2b76d5cc971e651cb3d926c899cdc6eb259844b9df44f84eb7fac934bcfaa7f'
  })

  depends_on 'diffutils' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libdb' # R
  depends_on 'linux_pam' # R
  depends_on 'openssl' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "mold -run ./configure \
      #{CREW_OPTIONS} \
      --enable-shared \
      --with-configdir=#{CREW_PREFIX}/etc/sasl2 \
      --with-cxx-shared \
      --with-dbpath=#{CREW_PREFIX}/etc/sasldb2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
