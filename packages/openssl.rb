require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1l'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '0b7a3e5e59c34827fe0c3a74b7ec8baef302b98fa80088d7f9153aa16fa76bd1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1l_armv7l/openssl-1.1.1l-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1l_armv7l/openssl-1.1.1l-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1l_x86_64/openssl-1.1.1l-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bc847247e12d2f68874dfd56408b51839e56cfeb00db431134e4dda6004ebb5a',
     armv7l: 'bc847247e12d2f68874dfd56408b51839e56cfeb00db431134e4dda6004ebb5a',
     x86_64: 'b99e603aadccb0544dc51026ce065bff345b63a0e5defcd254316a67bad541fc'
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
  # @ARCH_LDFLAGS = '-flto=auto'
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags} -flto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags} -flto"
  # @ARCH_C_LTO_FLAGS = "#{@arch_c_flags}  -ffat-lto-objects -flto=auto"
  # @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags}  -ffat-lto-objects -flto=auto"

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
    # For Libressl Compatibility
    # FileUtils.ln_s "#{CREW_LIB_PREFIX}/libssl.so", "#{CREW_DEST_LIB_PREFIX}/libssl.so.48"
    # FileUtils.ln_s "#{CREW_LIB_PREFIX}/libcrypto.so", "#{CREW_DEST_LIB_PREFIX}/libcrypto.so.46"
  end
end
