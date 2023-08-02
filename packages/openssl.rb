require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '3.0.10' # Do not use @_ver here, it will break the installer.
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-3.0.10.tar.gz'
  source_sha256 '1761d4f5b13a1028b9b6f3d4b8e17feb0cedc9370f6afe61d7193d2cdce83323'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.10_armv7l/openssl-3.0.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.10_armv7l/openssl-3.0.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.10_i686/openssl-3.0.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.10_x86_64/openssl-3.0.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a8976997294adeffc28cdebaeb795d4ded24ea1fb0f9e09fb43f9c50d3780f23',
     armv7l: 'a8976997294adeffc28cdebaeb795d4ded24ea1fb0f9e09fb43f9c50d3780f23',
       i686: '83fbfacd93301d23564451d35c84da6b5ff6dbf412fa555a267d09fe6384182d',
     x86_64: 'f4a5031529521eaf0da31cbcd6dd405a7c5dd7219573b2fcc4e931ef6e32a7b9'
  })

  depends_on 'ccache' => :build
  depends_on 'glibc' # R

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
    @no_tests_target = `openssl version | awk '{print $2}'`.chomp == version.to_s ? 'no-tests' : ''

    # This gives you the list of OpenSSL configure targets
    system './Configure LIST'
    system "PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
      CFLAGS=\"#{@ARCH_C_LTO_FLAGS}\" CXXFLAGS=\"#{@ARCH_CXX_LTO_FLAGS}\" \
      LDFLAGS=\"#{@ARCH_LDFLAGS}\" \
      mold -run ./Configure --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --openssldir=#{CREW_PREFIX}/etc/ssl \
      #{@openssl_configure_target} #{@no_tests_target}"
    system 'make'
  end

  def self.check
    # ecdsatest fails on i686
    # collect2: fatal error: ld terminated with signal 11 [Segmentation fault], core dumped
    # http_test fails on x86_64
    # collect2: error: ld returned 127 exit status
    return if ARCH == 'i686' || ARCH == 'x86_64'

    # Don't run tests if we are just rebuilding the same version of openssl.
    system 'make test' unless `openssl version | awk '{print $2}'`.chomp == version.to_s
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install_sw install_ssldirs"
    # Extract OpenSSL 1.1.1 libraries for backwards compatibility purposes
    # from the openssl111 package.
    # Builds and rebuilds of packages against OpenSSL should automatically
    # build against OpenSSL 3.x and not against OpenSSL 1.1.1x.
    File.write 'openssl111_files', <<~EOF
      #{CREW_LIB_PREFIX[1..]}/libcrypto.so.1.1
      #{CREW_LIB_PREFIX[1..]}/libssl.so.1.1
    EOF
    @cur_dir = `pwd`.chomp
    @legacy_version = '1.1.1v'
    case ARCH
    when 'aarch64', 'armv7l'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_armv7l/openssl111-#{@legacy_version}-chromeos-armv7l.tar.zst",
                 '8183a4f518e52954fce37a0947cc5095f061fe36e596425eeff5b5fcb8c18ac0', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    when 'i686'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_i686/openssl111-#{@legacy_version}-chromeos-i686.tar.zst",
                 '04f084e0a943a09a1fbbb18dac0734d935dabf9dcbe50c9735795926e912102c', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    when 'x86_64'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_x86_64/openssl111-#{@legacy_version}-chromeos-x86_64.tar.zst",
                 '006e3d0d36e6193eb1221aa88ca5b34c5cb7ca75c38e982f85d9756e6fc26a0e', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    end
    Dir.chdir(CREW_DEST_DIR) do
      system "tar -Izstd -xv --files-from #{@cur_dir}/openssl111_files -f #{@cur_dir}/openssl111-#{@legacy_version}-chromeos.tar.zst"
    end
  end
end
