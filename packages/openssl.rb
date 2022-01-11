require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1m'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'f89199be8b23ca45fc7cb9f1d8d3ee67312318286ad030f5316aca6462db6c96'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1m_armv7l/openssl-1.1.1m-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1m_armv7l/openssl-1.1.1m-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1m_i686/openssl-1.1.1m-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1m_x86_64/openssl-1.1.1m-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '43e77202d3b41ff91e76296c86f5940cf48f9b3bbc301c7695ae24930950bfd9',
     armv7l: '43e77202d3b41ff91e76296c86f5940cf48f9b3bbc301c7695ae24930950bfd9',
       i686: 'd944bb541df0b7b760064da7bc619dacdaa26609c38bf25b72b4b21245f83f67',
     x86_64: '8063f52834c2edddd08440adc7aa22334d9a937e937308c4b03c785f8624e5bc'
  })

  depends_on 'ccache' => :build

  case ARCH
  when 'aarch64', 'armv7l'
    # See https://sourceware.org/bugzilla/show_bug.cgi?id=27659
    # BFD (GNU Binutils) 2.36.1 internal error, aborting at ../../bfd/elfcode.h:224 in bfd_elf32_swap_symbol_out
    @arch_c_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=lld'
    @arch_cxx_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=lld'
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
  @ARCH_LDFLAGS = '-flto'
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags} -flto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags} -flto"


  def self.build
    # This gives you the list of OpenSSL configure targets
    system './Configure LIST'
    system "env CC=clang CXX=clang++ LD=ld.lld AR=llvm-ar RANLIB=llvm-ranlib \
    PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
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
  end
end
