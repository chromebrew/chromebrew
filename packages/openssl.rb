require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1i'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'e8be6a35fe41d10603c3cc635e93289ed00bf34b79671a3a4de64fcee00d5242'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6b4db90acb22c772dcb70d5688033b26230d3e10f2037ee56422f38b8fbd0029',
      armv7l: '6b4db90acb22c772dcb70d5688033b26230d3e10f2037ee56422f38b8fbd0029',
        i686: '22aae2e468cab25f6258c07cce8afe586b906297d2af602762516c5fd1cd93b5',
      x86_64: 'c5d19a3cab5f38898f4875ca2be57c3a8fb23c73726dd14e29f7bed02d252eb0',
  })


  depends_on 'ccache' => :build

  case ARCH
  when 'aarch64','armv7l'
    @ARCH_C_FLAGS = '-fPIC -march=armv7-a -mfloat-abi=hard'
    @ARCH_CXX_FLAGS = '-fPIC -march=armv7-a -mfloat-abi=hard'
    OPENSSL_CONFIGURE_TARGET = 'linux-generic32'
  when 'i686'
    @ARCH_C_FLAGS = '-fPIC'
    @ARCH_CXX_FLAGS = '-fPIC'
    OPENSSL_CONFIGURE_TARGET = 'linux-x86'
  when 'x86_64'
    @ARCH_C_FLAGS = '-fPIC'
    @ARCH_CXX_FLAGS = '-fPIC'
    OPENSSL_CONFIGURE_TARGET = 'linux-x86_64'
  end
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto=auto"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto=auto"

  def self.build
    # This gives you the list of OpenSSL configure targets
    system "./Configure LIST"
    system "env  PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
    CFLAGS=\"#{@ARCH_C_LTO_FLAGS}\" CXXFLAGS=\"#{@ARCH_CXX_LTO_FLAGS}\" \
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
    # For Libressl Compatibility
    #FileUtils.ln_s "#{CREW_LIB_PREFIX}/libssl.so", "#{CREW_DEST_LIB_PREFIX}/libssl.so.48"
    #FileUtils.ln_s "#{CREW_LIB_PREFIX}/libcrypto.so", "#{CREW_DEST_LIB_PREFIX}/libcrypto.so.46"
  end
end
