require 'package'

class Musl_curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.82.0'
  version @_ver.to_s
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '0aaa12d7bd04b0966254f2703ce80dd5c38dbbd76af0297d3d690cdce58a583c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.82.0_armv7l/musl_curl-7.82.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.82.0_armv7l/musl_curl-7.82.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.82.0_i686/musl_curl-7.82.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.82.0_x86_64/musl_curl-7.82.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c25654335e87ca6df017f9bdc7ab7d0b32fbb3a7a480f02a9bc89a4154f8838d',
     armv7l: 'c25654335e87ca6df017f9bdc7ab7d0b32fbb3a7a480f02a9bc89a4154f8838d',
       i686: '845e1165edd5c75c808a7a4bb4101482cb7acf10640588556303c0b9b685ae46',
     x86_64: '1f62fda183e6d01100e017b7072c32bc363306c08d3aa365b5804de5ef56ffd1'
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
    system 'src/curl -Lf https://github.com/skycocker/chromebrew/raw/master/install.sh -o /dev/null || exit 1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install', 'curl_LDFLAGS=-all-static'
    # Curl already includes man pages via "curl -M"
    FileUtils.rm_rf "#{CREW_DEST_MUSL_PREFIX}/share/man"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
  end
end
