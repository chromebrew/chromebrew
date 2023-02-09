require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.8'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.8_armv7l/musl_openssl-3.0.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.8_armv7l/musl_openssl-3.0.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.8_i686/musl_openssl-3.0.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.8_x86_64/musl_openssl-3.0.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '714297a8186e44a61d27618d8a0ef3cd81659149bd379927b6ea9ff2fcb828d4',
     armv7l: '714297a8186e44a61d27618d8a0ef3cd81659149bd379927b6ea9ff2fcb828d4',
       i686: '79660b0ae4c4ca70e2de38f937f15aa345fab9488a0a52c2780942c1980ebd40',
     x86_64: '37f4eb675bf536e7155635b680c80b05d11e2872022292768fe471a383e404ed'
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
