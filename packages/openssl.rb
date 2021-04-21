require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1k'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/openssl-1.1.1k-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/openssl-1.1.1k-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/openssl-1.1.1k-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/openssl-1.1.1k-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4b5a6ff1bbd03a7adf09acebe3b7a928de9a8520e260360f9f4fac8e7c83e903',
     armv7l: '4b5a6ff1bbd03a7adf09acebe3b7a928de9a8520e260360f9f4fac8e7c83e903',
       i686: '84d388677881fa56ccfa2dd7bd05ff8ef8ddcccebf30d60e7d13194e18c64e51',
     x86_64: 'fbcbe9955bd9b8cb9de3f7b2d5c77a4fcd9d8e5704afd192ad597871162a690d'
  })

  depends_on 'ccache' => :build

  case ARCH
  when 'aarch64', 'armv7l'
    @arch_c_flags = '-fPIC -march=armv7-a -mfloat-abi=hard'
    @arch_cxx_flags = '-fPIC -march=armv7-a -mfloat-abi=hard'
    @openssl_configure_target = 'linux-generic32'
  when 'i686'
    @arch_c_flags = '-fPIC'
    @arch_cxx_flags = '-fPIC'
    @openssl_configure_target = 'linux-x86'
  when 'x86_64'
    @arch_c_flags = '-fPIC'
    @arch_cxx_flags = '-fPIC'
    @openssl_configure_target = 'linux-x86_64'
  end
  @ARCH_LDFLAGS = '-flto=auto'
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags} -flto=auto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags} -flto=auto"

  def self.build
    # This gives you the list of OpenSSL configure targets
    system './Configure LIST'
    system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
      CFLAGS=\"#{@ARCH_C_LTO_FLAGS}\" CXXFLAGS=\"#{@ARCH_CXX_LTO_FLAGS}\" \
      LDFLAGS=\"#{@ARCH_LDFLAGS}\" \
      ./Configure --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --openssldir=#{CREW_PREFIX}/etc/ssl \
      #{@openssl_configure_target}"
    system 'make'
  end

  def self.check
    system 'make test'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
    # For Libressl Compatibility
    # FileUtils.ln_s "#{CREW_LIB_PREFIX}/libssl.so", "#{CREW_DEST_LIB_PREFIX}/libssl.so.48"
    # FileUtils.ln_s "#{CREW_LIB_PREFIX}/libcrypto.so", "#{CREW_DEST_LIB_PREFIX}/libcrypto.so.46"
  end
end
