require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  version '3.0.10'
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{version}.tar.gz"
  source_sha256 '1761d4f5b13a1028b9b6f3d4b8e17feb0cedc9370f6afe61d7193d2cdce83323'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.10_armv7l/musl_openssl-3.0.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.10_armv7l/musl_openssl-3.0.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.10_i686/musl_openssl-3.0.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.10_x86_64/musl_openssl-3.0.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4585df04bfd1347e87bf3f8cb7da9ab791817e054ea50369ccb2fc1bdab503ae',
     armv7l: '4585df04bfd1347e87bf3f8cb7da9ab791817e054ea50369ccb2fc1bdab503ae',
       i686: '29a5b6de94a8c1f16492b36f67695ce08f1569b588ec0e3770d621b300d0db50',
     x86_64: '5ff522b2a1a1b046bbdc30d2e11803b648e25716d68de6e126d3a86c4604f206'
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
