require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.12.0'
  source_url 'https://www.isc.org/downloads/file/bind-9-12-0/'
  source_sha256 '29870e9bf9dcc31ead3793ca754a7b0236a0785a7a9dc0f859a0bc42e19b3c82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9dd44bcabd7c6fff45ded90c1c5a1d7035efe892705eff6b7c4403126742fe7c',
     armv7l: '9dd44bcabd7c6fff45ded90c1c5a1d7035efe892705eff6b7c4403126742fe7c',
       i686: '53542e742f07b01367bec3b9c44b9464d7174402629911da3586f26c46f666cd',
     x86_64: 'c0cc93e84f7585eabe3bbd90d3163871777fb8e94fe3f0774d403f45a018c04d',
  })

  depends_on "openssl"
  depends_on "libcap"
  depends_on "readline"
  depends_on "diffutils"

  def self.build
    system "BUILD_CC=gcc ./configure \
                --with-randomdev=no \
                --with-ecdsa=yes \
                --with-gost=yes \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX}"  
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
