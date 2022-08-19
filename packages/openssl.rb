require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1q'
  version "#{@_ver}-1"
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'd7939ce614029cdff0b6c20f0e2e5703158a489a72b2507b8bd51bf8c8fd10ca'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-1_armv7l/openssl-1.1.1q-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-1_armv7l/openssl-1.1.1q-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-1_i686/openssl-1.1.1q-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-1_x86_64/openssl-1.1.1q-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8f9592bac4167da9829dcac529e98cded31c8d6824d691efff68220917d1bce7',
     armv7l: '8f9592bac4167da9829dcac529e98cded31c8d6824d691efff68220917d1bce7',
       i686: '2eabf1ab141f5873407cda3507456e9ab758fd69f44e8b76808cefa0dfe4a82a',
     x86_64: '78029b1bc2e02065713748a6dc649c8cde34e28df6f7347a9916b4121782f43d'
  })

  depends_on 'ccache' => :build
  no_patchelf

  case ARCH
  when 'aarch64', 'armv7l'
    @arch_c_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=mold'
    @arch_cxx_flags = '-fPIC -march=armv7-a -mfloat-abi=hard -fuse-ld=mold'
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
