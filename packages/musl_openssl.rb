require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.4'
  version @_ver.to_s
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '2831843e9a668a0ab478e7020ad63d2d65e51f72977472dc73efcefbafc0c00f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.4_armv7l/musl_openssl-3.0.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.4_armv7l/musl_openssl-3.0.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.4_i686/musl_openssl-3.0.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.4_x86_64/musl_openssl-3.0.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52f4a01d851567a1486125eceec055ad1982741e33d02a66075050182d5a1621',
     armv7l: '52f4a01d851567a1486125eceec055ad1982741e33d02a66075050182d5a1621',
       i686: 'a74cf389fcdf8626548d241e3ab018d9e63360d4d1f48f0632f9752e6ccc4d2e',
     x86_64: '8d1a7ae7ff7e9303a3c329b32bca0efd354595a78e715e1a49586de125d3c3e1'
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
