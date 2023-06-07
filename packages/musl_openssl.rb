require 'package'

class Musl_openssl < Package
  description 'The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
  homepage 'https://www.openssl.org'
  @_ver = '3.0.9'
  version @_ver
  license 'openssl'
  compatibility 'all'
  source_url "https://www.openssl.org/source/openssl-#{@_ver}.tar.gz"
  source_sha256 'eb1ab04781474360f77c318ab89d8c5a03abc38e63d65a603cabbf1b00a1dc90'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.9_armv7l/musl_openssl-3.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.9_armv7l/musl_openssl-3.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.9_i686/musl_openssl-3.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_openssl/3.0.9_x86_64/musl_openssl-3.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4b195b3d08718ade5b7cd8f0eb14a3aefa8057de600f54ff30e3edf0c5a85a35',
     armv7l: '4b195b3d08718ade5b7cd8f0eb14a3aefa8057de600f54ff30e3edf0c5a85a35',
       i686: 'a8c5e26c84647b6a4979621d40c61e52b4091c4cc49934a4dc8541de89040cd2',
     x86_64: 'd6384e4fcb7c60351686c3543459732f35f5c8e7a85feffdaeb939c1f4724e7e'
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
