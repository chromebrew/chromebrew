require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '1.1.1t' # Do not use @_ver here, it will break the installer.
  license 'openssl'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-1.1.1t.tar.gz'
  source_sha256 '8dee9b24bdb1dcbf0c3d1e9b02fb8f6bf22165e807f45adeb7c9677536859d3b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1t_armv7l/openssl-1.1.1t-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1t_armv7l/openssl-1.1.1t-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1t_i686/openssl-1.1.1t-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1t_x86_64/openssl-1.1.1t-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '88a36d1539c7c01af1f5e469b64c2760f43126bb75c0e63b53d3d61c2a6fbe7f',
     armv7l: '88a36d1539c7c01af1f5e469b64c2760f43126bb75c0e63b53d3d61c2a6fbe7f',
       i686: 'ce98c1898e57df1cbcceab08912e219fb5f27b0e4585315f7babdf524fa844dc',
     x86_64: 'd6583dc2c7566da33402cb8d7f9025189d65b8ba6300e752edcb0d74ebcb1f68'
  })

  # depends_on 'ccache' => :build
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
  @ARCH_C_LTO_FLAGS = "#{@arch_c_flags} -flto=auto"
  @ARCH_CXX_LTO_FLAGS = "#{@arch_cxx_flags} -flto=auto"

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
    # ecdsatest fails on i686
    # collect2: fatal error: ld terminated with signal 11 [Segmentation fault], core dumped
    return if ARCH == 'i686'

    # Don't run tests if we are just rebuilding the same version of openssl.
    system 'make test' unless `openssl version | awk '{print $2}'`.chomp == '1.1.1s'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
  end
end
