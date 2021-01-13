require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  _ver = '1.1.1i'
  version _ver
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{_ver}.tar.gz"
  source_sha256 'e8be6a35fe41d10603c3cc635e93289ed00bf34b79671a3a4de64fcee00d5242'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c3033ec7b37b5d451f528df4361a348a3dde750d71a131551039bed8880b5bb0',
      armv7l: 'c3033ec7b37b5d451f528df4361a348a3dde750d71a131551039bed8880b5bb0',
        i686: 'a1435f3a49db9dd3f07f3558cfffdbb0f724b15b1dba430ce3ad028b5d861366',
      x86_64: '52a43bc84d243218a2bf98c8895b1e366887a7e5308e711a3145ffe7879fe9e0',
  })


  depends_on 'ccache' => :build

  case ARCH
  when 'aarch64','armv7l'
    ARCH_C_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    ARCH_CXX_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    OPENSSL_CONFIGURE_TARGET = 'linux-generic32'
  when 'i686'
    ARCH_C_FLAGS = ''
    ARCH_CXX_FLAGS = ''
    OPENSSL_CONFIGURE_TARGET = 'linux-x86'
  when 'x86_64'
    ARCH_C_FLAGS = ''
    ARCH_CXX_FLAGS = ''
    OPENSSL_CONFIGURE_TARGET = 'linux-x86_64'
  end
  ARCH_C_LTO_FLAGS = "#{ARCH_C_FLAGS} -flto=auto"
  ARCH_CXX_LTO_FLAGS = "#{ARCH_CXX_FLAGS} -flto=auto"

  def self.build
    # This gives you the list of OpenSSL configure targets
    system "./Configure LIST"
    system "env  PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
    CFLAGS=\"#{ARCH_C_LTO_FLAGS}\" CXXFLAGS=\"#{ARCH_CXX_LTO_FLAGS}\" \
    ./Configure --prefix=#{CREW_PREFIX} \
    --libdir=#{CREW_LIB_PREFIX} \
    --openssldir=#{CREW_PREFIX}/etc/ssl \
    #{OPENSSL_CONFIGURE_TARGET}"
    system "make"
  end
  
  def self.check
    system "make test"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
  end
end
