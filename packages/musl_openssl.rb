require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.1'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'c311ad853353bce796edad01a862c50a8a587f62e7e2100ef465ab53ec9b06d1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.1_armv7l/musl_openssl-3.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.1_armv7l/musl_openssl-3.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.1_i686/musl_openssl-3.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.1_x86_64/musl_openssl-3.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b18e75dd8d59a179ec8e0c84ed50194253c3350494326059dcaadd0f1abb6d23',
     armv7l: 'b18e75dd8d59a179ec8e0c84ed50194253c3350494326059dcaadd0f1abb6d23',
       i686: '4e5f715a69c494f9d10b6a071a95771bdacde44253d692e4e9f84addad57de85',
     x86_64: '745cc2cd4f4f861f4d7ac4be33f724ab7da1b1a1ec833fb9dbb5828d2dc5e6fd'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build

  is_static

  case ARCH
  when 'aarch64', 'armv7l'
    @openssl_configure_target = 'linux-generic32'
  when 'i686'
    @openssl_configure_target = 'linux-elf'
  when 'x86_64'
    @openssl_configure_target = 'linux-x86_64'
  end

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
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
