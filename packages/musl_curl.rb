require 'package'

class Musl_curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.81.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 'a067b688d1645183febc31309ec1f3cdce9213d02136b6a6de3d50f69c95a7d3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.81.0_armv7l/musl_curl-7.81.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.81.0_armv7l/musl_curl-7.81.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.81.0_i686/musl_curl-7.81.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_curl/7.81.0_x86_64/musl_curl-7.81.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9acb67514a0db896686eaa834f3cf5c8818627521725d8b71325872ea1507259',
     armv7l: '9acb67514a0db896686eaa834f3cf5c8818627521725d8b71325872ea1507259',
       i686: 'bbff7492ea406c7150a4ff38420530035183269c58b6f4a73a0852e94172ab58',
     x86_64: 'a9d041801aa654b4086988f905f41628beaeefdc2e8df4f134c505202636877f'
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

  is_static

  def self.patch
    load "#{CREW_LIB_PATH}lib/musl.rb"
    # Curl 7.78.0 needs a patch to enable static builds.
    # See https://github.com/moparisthebest/static-curl/commit/0ab82474d449b7f2ea0d43451fd3951ebd49ddc3
    @curl_778_static_patch = <<~'CURL_HEREDOC'
      diff --git a/src/Makefile.am b/src/Makefile.am
      index 734373187..37e3a1564 100644
      --- a/src/Makefile.am
      +++ b/src/Makefile.am
      @@ -66,6 +66,9 @@ else
       curl_LDADD = $(top_builddir)/lib/libcurl.la @NSS_LIBS@ @SSL_LIBS@ @ZLIB_LIBS@ @CURL_NETWORK_AND_TIME_LIBS@
       endif

      +curl_LDFLAGS = $(curl_LDFLAGS)
      +curl_CPPFLAGS = $(AM_CPPFLAGS)
      +
       # if unit tests are enabled, build a static library to link them with
       if BUILD_UNITTESTS
       noinst_LTLIBRARIES = libcurltool.la
    CURL_HEREDOC
    File.write('curl_778_static.patch', @curl_778_static_patch)
    system 'patch -Np1 -i curl_778_static.patch'
    # Configure is broken in curl 7.81.0
    # See https://github.com/curl/curl/pull/8230
    @curl_781_configure_patch = <<~'CURL_CONFIGURE_HEREDOC'
      --- a/m4/curl-functions.m4	2022-01-03 16:36:46.000000000 +0000
      +++ b/m4/curl-functions.m4	2022-01-05 17:34:33.635107486 +0000
      @@ -6515,16 +6515,21 @@ dnl changes contained within this macro.

       AC_DEFUN([CURL_RUN_IFELSE], [
          case $host_os in
      -     darwin*) library_path_var=DYLD_LIBRARY_PATH ;;
      -     *)       library_path_var=LD_LIBRARY_PATH ;;
      +     darwin*)
      +      old=$DYLD_LIBRARY_PATH
      +      DYLD_LIBRARY_PATH=$CURL_LIBRARY_PATH:$old
      +      export DYLD_LIBRARY_PATH
      +      AC_RUN_IFELSE([AC_LANG_SOURCE([$1])], $2, $3, $4)
      +      DYLD_LIBRARY_PATH=$old # restore
      +     ;;
      +     *)
      +      old=$LD_LIBRARY_PATH
      +      LD_LIBRARY_PATH=$CURL_LIBRARY_PATH:$old
      +      export LD_LIBRARY_PATH
      +      AC_RUN_IFELSE([AC_LANG_SOURCE([$1])], $2, $3, $4)
      +      LD_LIBRARY_PATH=$old # restore
      +     ;;
          esac
      -
      -   eval "old=$$library_path_var"
      -   eval "$library_path_var=\$CURL_LIBRARY_PATH:\$old"
      -
      -   eval "export $library_path_var"
      -   AC_RUN_IFELSE([AC_LANG_SOURCE([$1])], $2, $3, $4)
      -   eval "$library_path_var=\$old" # restore
       ])

       dnl CURL_COVERAGE
    CURL_CONFIGURE_HEREDOC
    File.write('curl_781_configure.patch', @curl_781_configure_patch)
    system 'patch -Np1 -i curl_781_configure.patch'
  end

  def self.build
    # Not sure how to avoid this hack.
    # FileUtils.mv "#{CREW_PREFIX}/include", "#{CREW_PREFIX}/include.disabled"
    @curl_lib_deps = "-l:libunbound.a \
      -l:libresolv.a \
      -l:libm.a \
      -l:libbrotlicommon-static.a \
      -l:libbrotlidec-static.a \
      -l:libzstd.a \
      -l:libz.a \
      -l:libssl.a \
      -l:libcrypto.a \
      -l:libpthread.a \
      -l:libncursesw.a \
      -l:libtinfow.a \
      -l:libunistring.a \
      -l:libidn2.a"

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
    # begin
    system "#{MUSL_ENV_OPTIONS.gsub("CPPFLAGS='", "CPPFLAGS='-DCURL_STATICLIB ")} \
        make curl_LDFLAGS='-static -all-static -L#{CREW_MUSL_PREFIX}/lib -Wl,-rpath=#{CREW_MUSL_PREFIX}/lib'"
    # rescue StandardError
    # undoing prior hack...
    # FileUtils.mv "#{CREW_PREFIX}/include.disabled", "#{CREW_PREFIX}/include"
    # end
    # FileUtils.mv "#{CREW_PREFIX}/include.disabled", "#{CREW_PREFIX}/include" unless Dir.exist?("#{CREW_PREFIX}/include")
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
