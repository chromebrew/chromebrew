require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1s'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'c5ac01e760ee6ff0dab61d6b2bbd30146724d063eb322180c6f18a6f74e4b6aa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1s_armv7l/openssl-1.1.1s-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1s_armv7l/openssl-1.1.1s-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1s_i686/openssl-1.1.1s-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1s_x86_64/openssl-1.1.1s-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6befd72e7eac1d745316502b52ad14f72b24cee3bc810920886fe4ae85f1ec41',
     armv7l: '6befd72e7eac1d745316502b52ad14f72b24cee3bc810920886fe4ae85f1ec41',
       i686: '690f62d599ec878d59e237aead76631407a48e1b070729a44f00d4e8a6a59193',
     x86_64: '69e980b70b331ca265ff22c5e649fc31195586fbb61a59f274320610e68a6263'
  })

  depends_on 'ccache' => :build
  depends_on 'glibc' # R

  no_patchelf
  no_zstd

  case ARCH
  when 'aarch64', 'armv7l'
    @arch_c_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=mold'
    @arch_cxx_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=mold'
    @openssl_configure_target = 'linux-generic32'
  when 'i686'
    @arch_c_flags = '-fPIC -fuse-ld=mold'
    @arch_cxx_flags = '-fPIC -fuse-ld=mold'
    @openssl_configure_target = 'linux-x86'
  when 'x86_64'
    @arch_c_flags = '-fPIC -fuse-ld=mold'
    @arch_cxx_flags = '-fPIC -fuse-ld=mold'
    @openssl_configure_target = 'linux-x86_64'
  end
  @ARCH_LDFLAGS = '-flto'
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags} -flto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags} -flto"

  def self.build
    # This gives you the list of OpenSSL configure targets
    system './Configure LIST'
    system "PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
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
