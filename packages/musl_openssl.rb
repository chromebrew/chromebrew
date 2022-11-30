require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.7'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '83049d042a260e696f62406ac5c08bf706fd84383f945cf21bd61e9ed95c396e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.7_armv7l/musl_openssl-3.0.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.7_armv7l/musl_openssl-3.0.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.7_i686/musl_openssl-3.0.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.7_x86_64/musl_openssl-3.0.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d9aa6f889b0b804025ce70eed32894e1c07b7762ae94374a29137bf1b564e90',
     armv7l: '3d9aa6f889b0b804025ce70eed32894e1c07b7762ae94374a29137bf1b564e90',
       i686: '3ac71992c6298f746d4bb497b1091acf1a18d09c4337ee733ae0b38a842cc18f',
     x86_64: '1601e49a3221acab4897b99e4de3c975b6128f304eb7a99b89de72381ed1203e'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build

  is_musl
  is_static

  def self.build
    # rand-seed is needed to keep git from breaking with an error about
    # insufficient randomness being available.
    case ARCH
    when 'aarch64', 'armv7l'
      @openssl_configure_target = 'linux-generic32'
      # rdcpu breaks armv7l builds with OpenSSL 3.0.3
      @rand_seed = 'os,getrandom'
    when 'i686'
      @openssl_configure_target = 'linux-elf'
      @rand_seed = 'os,getrandom,rdcpu'
    when 'x86_64'
      @openssl_configure_target = 'linux-x86_64'
      @rand_seed = 'os,getrandom,rdcpu'
    end
    # Use debian build options to work around problem building on armv7l.
    # Disable cast because it breaks i686 builds.
    system "#{MUSL_ENV_OPTIONS} ./Configure \
        --prefix=#{CREW_MUSL_PREFIX} \
        --openssldir=#{CREW_MUSL_PREFIX} \
        --libdir=#{CREW_MUSL_PREFIX}/lib \
        enable-cms \
        no-capieng \
        enable-rfc3779 \
        no-cast \
        no-idea \
        no-mdc2 \
        no-rc5 \
        no-ssl3 \
        no-ssl3-method \
        no-tests \
        no-zlib \
        --with-rand-seed=#{@rand_seed} \
        -static --static \
        -Wl,-rpath=#{CREW_MUSL_PREFIX}/lib -Wl,--enable-new-dtags \
        -Wl,-Bsymbolic \
        #{@openssl_configure_target}"
    system "#{MUSL_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install_sw'
  end
end
