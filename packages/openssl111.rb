require 'package'

class Openssl111 < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '1.1.1w' # Do not use @_ver here, it will break the installer.
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{version}.tar.gz"
  source_sha256 'cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1w_armv7l/openssl111-1.1.1w-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1w_armv7l/openssl111-1.1.1w-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1w_i686/openssl111-1.1.1w-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1w_x86_64/openssl111-1.1.1w-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '650209f527994f5c8bd57d1f2b5c42174d66472ca2a40116f66a043bd6e4c046',
     armv7l: '650209f527994f5c8bd57d1f2b5c42174d66472ca2a40116f66a043bd6e4c046',
       i686: 'a409ebebe5b5789e3ed739bc540d150faa66d9e33e6f19000b1b4e110a86d618',
     x86_64: 'e95e8cf456fc9168de148946c38cdda6a1e7482bdcbb4121766a178a32421917'
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
    system 'make test' unless `openssl version | awk '{print $2}'`.chomp == version
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
  end
end
