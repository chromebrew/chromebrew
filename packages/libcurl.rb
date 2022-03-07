require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.81.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 'a067b688d1645183febc31309ec1f3cdce9213d02136b6a6de3d50f69c95a7d3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.81.0_armv7l/libcurl-7.81.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.81.0_armv7l/libcurl-7.81.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.81.0_i686/libcurl-7.81.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.81.0_x86_64/libcurl-7.81.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '92eef28a611d71bf61031dcc97266cb8ca297a77e3bd4736cd6a4cb9806eabba',
     armv7l: '92eef28a611d71bf61031dcc97266cb8ca297a77e3bd4736cd6a4cb9806eabba',
       i686: '2c1b600dd8e66ce7e561f7c8f08026158db9e2f63d88e534720da751719b40ff',
     x86_64: 'fb1a71b10267c947a800114c7af2b3b9c8559ba489ab4dee0c08fc9e628343bb'
  })

  depends_on 'brotli' => :build
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.patch
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
    system 'autoreconf -fvi'
  end

  def self.build
    @libssh = '--with-libssh'
    case ARCH
    when 'i686'
      @libssh = '--without-libssh'
    end

    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      #{@libssh} \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
