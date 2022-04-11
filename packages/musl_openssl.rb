require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.2'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 '98e91ccead4d4756ae3c9cde5e09191a8e586d9f4d50838e7ec09d6411dfdb63'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.2_armv7l/musl_openssl-3.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.2_armv7l/musl_openssl-3.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.2_i686/musl_openssl-3.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.2_x86_64/musl_openssl-3.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '159c7b46cdff07ed3ae35c54c80a667d507a6613c9ee1f14f0f3c8c710993b06',
     armv7l: '159c7b46cdff07ed3ae35c54c80a667d507a6613c9ee1f14f0f3c8c710993b06',
       i686: '1098d4e577758cdb103edc861149d6053f2ebe1b79777da6461a7c1961eaadd5',
     x86_64: '2f482f0922c4a4188622416df2f3e31b555cafac2b42635944452c72c7ab05c2'
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
    system "#{MUSL_ENV_OPTIONS} ./Configure \
        --prefix=#{CREW_MUSL_PREFIX} \
        --openssldir=#{CREW_MUSL_PREFIX} \
        --libdir=#{CREW_MUSL_PREFIX}/lib \
        no-tests \
        no-zlib \
        no-async \
        no-comp \
        no-idea \
        no-mdc2 \
        no-rc5 \
        no-ec2m \
        no-sm2 \
        no-sm4 \
        no-ssl2 \
        no-ssl3 \
        no-seed \
        no-weak-ssl-ciphers \
        no-des \
        no-cast \
        --with-rand-seed=rdcpu,os \
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
