require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '3.0.9' # Do not use @_ver here, it will break the installer.
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-3.0.9.tar.gz'
  source_sha256 'eb1ab04781474360f77c318ab89d8c5a03abc38e63d65a603cabbf1b00a1dc90'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.9_armv7l/openssl-3.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.9_armv7l/openssl-3.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.9_i686/openssl-3.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.9_x86_64/openssl-3.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '909203f4348a71d347728ef29d6e6364412dfaeff57c95e4cbea838e04c61cf7',
     armv7l: '909203f4348a71d347728ef29d6e6364412dfaeff57c95e4cbea838e04c61cf7',
       i686: '9732a9278f6d4434a5c9b5bf95337d731ea254c56f0333867d1f414e5763af50',
     x86_64: '093cda273b9bd15e6e33b07f0acae8079c42461db2fe4b619a611d3687d11fd6'
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
    return if ARCH == 'i686'

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
    @legacy_version = '1.1.1u'
    case ARCH
    when 'aarch64', 'armv7l'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_armv7l/openssl111-#{@legacy_version}-chromeos-armv7l.tar.zst",
                 '99b920309fdd7e5b9512bdbe8a0f75ee8196894a8b67554545de399d6a3b9303', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    when 'i686'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_i686/openssl111-#{@legacy_version}-chromeos-i686.tar.zst",
                 '5d266d546f82e3040b71492b8c670d0fc12caac9e192afd761b04179a8bda93f', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    when 'x86_64'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl111/#{@legacy_version}_x86_64/openssl111-#{@legacy_version}-chromeos-x86_64.tar.zst",
                 'fcd6b8ecab009fa65c2e24adf1188b341f01dc1a8883035d54ddb63307c96f67', "openssl111-#{@legacy_version}-chromeos.tar.zst"
    end
    Dir.chdir(CREW_DEST_DIR) do
      system "tar -Izstd -xv --files-from #{@cur_dir}/openssl111_files -f #{@cur_dir}/openssl111-#{@legacy_version}-chromeos.tar.zst"
    end
  end
end
