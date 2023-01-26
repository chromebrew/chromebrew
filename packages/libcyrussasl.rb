require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.28'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.28/cyrus-sasl-2.1.28.tar.gz'
  source_sha256 '7ccfc6abd01ed67c1a0924b353e526f1b766b21f42d4562ee635a8ebfc5bb38c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28_armv7l/libcyrussasl-2.1.28-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28_armv7l/libcyrussasl-2.1.28-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28_i686/libcyrussasl-2.1.28-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcyrussasl/2.1.28_x86_64/libcyrussasl-2.1.28-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'be22b132e1bd8d4576fcce5b05fd8d9954c118f7b08ee5ecc81695216a57b21f',
     armv7l: 'be22b132e1bd8d4576fcce5b05fd8d9954c118f7b08ee5ecc81695216a57b21f',
       i686: '80f070c21fd19968a95c4a5f5db1d63f4de4c7555eccfb0f4d27cdecce0f3980',
     x86_64: 'fa5421975beaac8151c7039d48164e3fbe12ece34e28f84445303bd2ab91ce35'
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
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-shared \
      --enable-static \
      --with-configdir=#{CREW_PREFIX}/etc/sasl2 \
      --with-cxx-shared \
      --with-dbpath=#{CREW_PREFIX}/etc/sasldb2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
