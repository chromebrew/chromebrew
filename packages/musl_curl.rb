require 'package'

class Musl_curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '7.84.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 '2d118b43f547bfe5bae806d8d47b4e596ea5b25a6c1f080aef49fbcd817c5db8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.84.0_armv7l/musl_curl-7.84.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.84.0_armv7l/musl_curl-7.84.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.84.0_i686/musl_curl-7.84.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.84.0_x86_64/musl_curl-7.84.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c21d0bbc43fd965743a37b49bb53663e510df3940e00b83cd6fd0f91e0ae085',
     armv7l: '2c21d0bbc43fd965743a37b49bb53663e510df3940e00b83cd6fd0f91e0ae085',
       i686: '1e27afa774b53a5c0db25b7779f09997540870cb549ce01a57e44a4d5e93a8f1',
     x86_64: '403fb26245e958681aef632dd859ce645ab2339cc72ad46e7ad983c789976448'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'musl_libunbound' => :build
  depends_on 'musl_brotli' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_zstd' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  is_musl
  is_static
  patchelf

  def self.patch
    # Fix arm build error
    # easy_lock.h:56:7: error: implicit declaration of function 'sched_yield' [-Werror=implicit-function-declaration]
    # via https://github.com/curl/curl/pull/9054 & https://github.com/curl/curl/pull/9056
    downloader 'https://github.com/curl/curl/commit/e2e7f54b7bea521fa8373095d0f43261a720cda0.patch',
               '9b011c957cedcc089b53399f31328b1ebb7ec87dd5eeefd1f83c7fc8741405a0'
    system 'patch -p1 -i e2e7f54b7bea521fa8373095d0f43261a720cda0.patch'
    downloader 'https://github.com/curl/curl/commit/5a1a892565443fa4145888c6150da65c9a33d15c.patch',
               '9a83b1b8b7fa3f6951bf890d6af7bc37c830d0741849d8b1e98acfb5dbdaf563'
    system 'patch -p1 -i 5a1a892565443fa4145888c6150da65c9a33d15c.patch'
  end

  def self.build
    @curl_lib_deps = "#{CREW_MUSL_PREFIX}/lib/libunbound.a \
      #{CREW_MUSL_PREFIX}/lib/libresolv.a \
      #{CREW_MUSL_PREFIX}/lib/libm.a \
      #{CREW_MUSL_PREFIX}/lib/libbrotlicommon-static.a \
      #{CREW_MUSL_PREFIX}/lib/libbrotlidec-static.a \
      #{CREW_MUSL_PREFIX}/lib/libzstd.a \
      #{CREW_MUSL_PREFIX}/lib/libz.a \
      #{CREW_MUSL_PREFIX}/lib/libssl.a \
      #{CREW_MUSL_PREFIX}/lib/libcrypto.a \
      #{CREW_MUSL_PREFIX}/lib/libpthread.a \
      #{CREW_MUSL_PREFIX}/lib/libncursesw.a \
      #{CREW_MUSL_PREFIX}/lib/libtinfow.a \
      #{CREW_MUSL_PREFIX}/lib/libidn2.a \
      #{CREW_MUSL_PREFIX}/lib/libunistring.a"

    system 'autoreconf -fvi'
    system 'filefix'
    # ntlm disabled because requisite openssl des has issues building on i686
    system "#{MUSL_ENV_OPTIONS.gsub("CPPFLAGS='", "CPPFLAGS='-DCURL_STATICLIB ")} \
      LIBS='#{@curl_lib_deps} \
      -L#{CREW_MUSL_PREFIX}/lib' \
      CURL_LIBRARY_PATH=#{CREW_MUSL_PREFIX}/lib \
      ./configure --prefix=#{CREW_MUSL_PREFIX} \
      --libdir=#{CREW_MUSL_PREFIX}/lib \
      --disable-ares \
      --disable-debug \
      --disable-dependency-tracking \
      --disable-imap \
      --disable-ldap \
      --disable-ldaps \
      --disable-maintainer-mode \
      --disable-ntlm \
      --disable-rtsp \
      --disable-shared \
      --enable-ipv6 \
      --enable-static \
      --enable-unix-sockets \
      --with-brotli=#{CREW_MUSL_PREFIX} \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-ca-fallback \
      --with-libidn2=#{CREW_MUSL_PREFIX} \
      --without-librtmp \
      --without-libpsl \
      --with-openssl=#{CREW_MUSL_PREFIX} \
      --with-zlib=#{CREW_MUSL_PREFIX}"
    system "#{MUSL_ENV_OPTIONS.gsub("CPPFLAGS='", "CPPFLAGS='-DCURL_STATICLIB ")} \
        make curl_LDFLAGS='-static -all-static -L#{CREW_MUSL_PREFIX}/lib -Wl,-rpath=#{CREW_MUSL_PREFIX}/lib'"
  end

  def self.check
    # Fail if built curl is not statically built.
    system 'readelf -d src/curl | grep "Shared library" && exit 1 || true'
    # Fail if built curl unable to download files
    system 'src/curl -Lf https://github.com/chromebrew/chromebrew/raw/master/install.sh -o /dev/null || exit 1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install', 'curl_LDFLAGS=-all-static'
    # Curl already includes man pages via "curl -M"
    FileUtils.rm_rf "#{CREW_DEST_MUSL_PREFIX}/share/man"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
  end
end
