require 'buildsystems/autotools'

class Libcyrussasl < Autotools
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.28-2'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.28/cyrus-sasl-2.1.28.tar.gz'
  source_sha256 '7ccfc6abd01ed67c1a0924b353e526f1b766b21f42d4562ee635a8ebfc5bb38c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '256fe21c3b7e90413a775ddbe4e84354a5b626af4155aa9610f676c49ea343d1',
     armv7l: '256fe21c3b7e90413a775ddbe4e84354a5b626af4155aa9610f676c49ea343d1',
       i686: '1dba7c51855286e740b042c05be01fcdddbd143ebc04cad955d4386a7a4c0797',
     x86_64: '7bbcc424ee8c4f9175dd089112fd8305ca67a35a4a3262c562abef4b8d7fada4'
  })

  depends_on 'diffutils' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libdb' # R
  depends_on 'linux_pam' # R
  depends_on 'openssl' # R

  configure_options "--enable-shared \
        --with-configdir=#{CREW_PREFIX}/etc/sasl2 \
        --with-cxx-shared \
        --with-dbpath=#{CREW_PREFIX}/etc/sasldb2"
end
