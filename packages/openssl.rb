require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1n'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '40dceb51a4f6a5275bde0e6bf20ef4b91bfc32ed57c0552e2e8e15463372b17a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1n_armv7l/openssl-1.1.1n-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1n_armv7l/openssl-1.1.1n-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1n_i686/openssl-1.1.1n-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1n_x86_64/openssl-1.1.1n-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c3db5187b994eca5957af581c1390e57bf87a9cc72cfa5354aa71f9a500144b2',
     armv7l: 'c3db5187b994eca5957af581c1390e57bf87a9cc72cfa5354aa71f9a500144b2',
       i686: '8797c98e2f9116c71ac86df5d448d7aaaf9b291c85c7febb73e872caeb3dec6b',
     x86_64: '529c2dd2f5f65ae4a55f56985aa96cbec6cd6f214987fbdadb49a53c0dbee815'
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
