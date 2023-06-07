require 'package'

class Openssl111 < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '1.1.1u' # Do not use @_ver here, it will break the installer.
  license 'openssl'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-1.1.1u.tar.gz'
  source_sha256 'e2f8d84b523eecd06c7be7626830370300fbcc15386bf5142d72758f6963ebc6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1u_armv7l/openssl111-1.1.1u-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1u_armv7l/openssl111-1.1.1u-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1u_i686/openssl111-1.1.1u-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1u_x86_64/openssl111-1.1.1u-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '99b920309fdd7e5b9512bdbe8a0f75ee8196894a8b67554545de399d6a3b9303',
     armv7l: '99b920309fdd7e5b9512bdbe8a0f75ee8196894a8b67554545de399d6a3b9303',
       i686: '5d266d546f82e3040b71492b8c670d0fc12caac9e192afd761b04179a8bda93f',
     x86_64: 'fcd6b8ecab009fa65c2e24adf1188b341f01dc1a8883035d54ddb63307c96f67'
  })

  depends_on 'glibc' # R
  conflicts_ok # This is only here for use in builds. We should never install this, as the default
  # OpenSSL is version 3.x, and this package is only being used to provide some libraries for
  # backwards compatibility.

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
      mold -run ./Configure --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --openssldir=#{CREW_PREFIX}/etc/ssl \
      #{@openssl_configure_target}"
    system 'make'
  end

  def self.check
    # Don't run tests if we are just rebuilding the same version of openssl.
    system 'make test' unless `openssl version | awk '{print $2}'`.chomp == '1.1.1u'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
  end
end
