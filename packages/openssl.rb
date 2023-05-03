require 'package'

class Openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '3.0.8' # Do not use @_ver here, it will break the installer.
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://www.openssl.org/source/openssl-3.0.8.tar.gz'
  source_sha256 '6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.8_armv7l/openssl-3.0.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.8_armv7l/openssl-3.0.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.8_i686/openssl-3.0.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/3.0.8_x86_64/openssl-3.0.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7259e84e6b50a222eed28ad8c199a474ae2bb2acf9b1085359324714d7d4ca01',
     armv7l: '7259e84e6b50a222eed28ad8c199a474ae2bb2acf9b1085359324714d7d4ca01',
       i686: 'b83f9d555e58cd3364a0c11070f2610ec2afe7225d0b24f5509b087f5590f2ff',
     x86_64: '82f7b876e2dbc1a87fdd5ee54540c69c6e26a18d3169352867906e83a986fdd2'
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
    # Extract OpenSSL 1.1.1t libraries for backwards compatibility purposes.
    # Builds and rebuilds of packages against OpenSSL should automatically
    # build against OpenSSL 3.x and not against OpenSSL 1.1.1x.
    File.write 'openssl111_files', <<~EOF
      #{CREW_LIB_PREFIX[1..-1]}/libcrypto.so.1.1
      #{CREW_LIB_PREFIX[1..-1]}/libssl.so.1.1
    EOF
    @cur_dir = `pwd`.chomp
    @legacy_version = '1.1.1t'
    case ARCH
    when 'aarch64', 'armv7l'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/#{@legacy_version}_armv7l/openssl-#{@legacy_version}-chromeos-armv7l.tar.xz",
                 '88a36d1539c7c01af1f5e469b64c2760f43126bb75c0e63b53d3d61c2a6fbe7f', "openssl-#{@legacy_version}-chromeos.tar.xz"
    when 'i686'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/#{@legacy_version}_i686/openssl-#{@legacy_version}-chromeos-i686.tar.xz",
                 'ce98c1898e57df1cbcceab08912e219fb5f27b0e4585315f7babdf524fa844dc', "openssl-#{@legacy_version}-chromeos.tar.xz"
    when 'x86_64'
      downloader "https://gitlab.com/api/v4/projects/26210301/packages/generic/openssl/#{@legacy_version}_x86_64/openssl-#{@legacy_version}-chromeos-x86_64.tar.xz",
                 'd6583dc2c7566da33402cb8d7f9025189d65b8ba6300e752edcb0d74ebcb1f68', "openssl-#{@legacy_version}-chromeos.tar.xz"
    end
    Dir.chdir(CREW_DEST_DIR) do
      system "tar -xv --files-from #{@cur_dir}/openssl111_files -f #{@cur_dir}/openssl-#{@legacy_version}-chromeos.tar.xz"
    end
  end
end
