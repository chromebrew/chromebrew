require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1k'
  version "#{@_ver}-1"
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-1_armv7l/openssl-1.1.1k-1-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-1_armv7l/openssl-1.1.1k-1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-1_i686/openssl-1.1.1k-1-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-1_x86_64/openssl-1.1.1k-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0f5d3fa673b9df81c9a1aa26d5315cd74e70322d7a88d97aaf12361e757b3e0d',
    armv7l: '0f5d3fa673b9df81c9a1aa26d5315cd74e70322d7a88d97aaf12361e757b3e0d',
    i686: '8eba22bcb2a3cb5aaf68137a28eb6b319c89e0c71020c8a1f55973aca24e5116',
    x86_64: 'ae64526253eae95b6ef825639c37078872a1ed454bde4a2b40a245c16922060e'
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
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags}  -ffat-lto-objects -flto=auto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags}  -ffat-lto-objects -flto=auto"

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
