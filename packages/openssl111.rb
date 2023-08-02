require 'package'

class Openssl111 < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '1.1.1v' # Do not use @_ver here, it will break the installer.
  license 'openssl'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-1.1.1v.tar.gz'
  source_sha256 'd6697e2871e77238460402e9362d47d18382b15ef9f246aba6c7bd780d38a6b0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1v_armv7l/openssl111-1.1.1v-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1v_armv7l/openssl111-1.1.1v-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1v_i686/openssl111-1.1.1v-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/1.1.1v_x86_64/openssl111-1.1.1v-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8183a4f518e52954fce37a0947cc5095f061fe36e596425eeff5b5fcb8c18ac0',
     armv7l: '8183a4f518e52954fce37a0947cc5095f061fe36e596425eeff5b5fcb8c18ac0',
       i686: '04f084e0a943a09a1fbbb18dac0734d935dabf9dcbe50c9735795926e912102c',
     x86_64: '006e3d0d36e6193eb1221aa88ca5b34c5cb7ca75c38e982f85d9756e6fc26a0e'
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
