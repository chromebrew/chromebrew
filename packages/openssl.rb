require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1p'
  version @_ver.to_s
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'bf61b62aaa66c7c7639942a94de4c9ae8280c08f17d4eac2e44644d9fc8ace6f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1p_armv7l/openssl-1.1.1p-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1p_armv7l/openssl-1.1.1p-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1p_i686/openssl-1.1.1p-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1p_x86_64/openssl-1.1.1p-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '738d788a6a681e4509735f7fdc7b7639047228875573e2ef8c707f9250235d52',
     armv7l: '738d788a6a681e4509735f7fdc7b7639047228875573e2ef8c707f9250235d52',
       i686: 'b44fa7593a7ef2886b593eeeac9dd703945ea350dbe467cfb528f846bccf0602',
     x86_64: '5e85227ee00f2cc8d0ed63c63c085490bae00b9ad43ece3f805f64215b3a8119'
  })

  depends_on 'ccache' => :build
  no_patchelf

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
    # Don't run tests if we are just rebuilding the same version of openssl.
    system 'make test' unless `openssl version | awk '{print $2}'`.chomp == @_ver
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
  end
end
