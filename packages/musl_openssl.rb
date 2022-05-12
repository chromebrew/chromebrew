require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.3'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'ee0078adcef1de5f003c62c80cc96527721609c6f3bb42b7795df31f8b558c0b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.3_armv7l/musl_openssl-3.0.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.3_armv7l/musl_openssl-3.0.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.3_i686/musl_openssl-3.0.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.3_x86_64/musl_openssl-3.0.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b5e5e2ee3f997a5c4b0ed556c9910152620cdb6077a35cdc3618ffbc3ae19783',
     armv7l: 'b5e5e2ee3f997a5c4b0ed556c9910152620cdb6077a35cdc3618ffbc3ae19783',
       i686: 'd05edf1e5a84af558c55b8370164dcb7b00c9b3ef05491102c0d4ae7a716e768',
     x86_64: 'bc294a522e698f72afba02f6b1e1b757fca513c0d082cbfef6096b89cd122bd4'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build

  is_musl
  is_static

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      @openssl_configure_target = 'linux-generic32'
    when 'i686'
      @openssl_configure_target = 'linux-elf'
    when 'x86_64'
      @openssl_configure_target = 'linux-x86_64'
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
