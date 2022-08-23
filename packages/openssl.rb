require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '1.1.1q'
  version "#{@_ver}-2"
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'd7939ce614029cdff0b6c20f0e2e5703158a489a72b2507b8bd51bf8c8fd10ca'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-2_armv7l/openssl-1.1.1q-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-2_armv7l/openssl-1.1.1q-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-2_i686/openssl-1.1.1q-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/1.1.1q-2_x86_64/openssl-1.1.1q-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ce7b09378b0604b14a6f66f09d7b797001be0a2037ab73c0acd7614f6844dffc',
     armv7l: 'ce7b09378b0604b14a6f66f09d7b797001be0a2037ab73c0acd7614f6844dffc',
       i686: '9490d940c0eb928a70b2043932d41d2fd5f486b86067616ed76cb591cb6e4c3b',
     x86_64: 'b408d3943acd24811104f30f4de07ef64df56a8a44467e113418fcf86906a4ee'
  })

  depends_on 'ccache' => :build
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
