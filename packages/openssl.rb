require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1k'
  version "#{@_ver}-3"
  compatibility 'all'
  license 'openssl'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-3_armv7l/openssl-1.1.1k-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-3_armv7l/openssl-1.1.1k-3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-2_i686/openssl-1.1.1k-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1k-2_x86_64/openssl-1.1.1k-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d6acf58d87071df456b02676ff3693668517b29249964501da173ad8880cd8b',
     armv7l: '0d6acf58d87071df456b02676ff3693668517b29249964501da173ad8880cd8b',
       i686: '5a55581745e62d8e3697b7dfa7b91624c0aeda94cf925c1feb079163e3923b0b',
     x86_64: 'd095621c44c8607c93b3881cbdc71d8bb219f1d48f93abf0c626d3f7f2eddba7'
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
