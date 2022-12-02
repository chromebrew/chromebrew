require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.86.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '2d61116e5f485581f6d59865377df4463f2e788677ac43222b496d4e49fb627b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.86.0_armv7l/libcurl-7.86.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.86.0_armv7l/libcurl-7.86.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.86.0_i686/libcurl-7.86.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.86.0_x86_64/libcurl-7.86.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5e1dba3eef4a0cf7fd9c2edba1a1c5f823a2c3bbace196cb6102099f963aa3ad',
     armv7l: '5e1dba3eef4a0cf7fd9c2edba1a1c5f823a2c3bbace196cb6102099f963aa3ad',
       i686: '4f70bccbcc26c3182d76d542fa75b6ef70aea5352479fb2a24dd0b2af1f529c8',
     x86_64: '8d579bd3ca36b7304e4505dd2a05a9872f667057b6974396d3c24a49727a416c'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'glibc' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunistring' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_patchelf

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "mold -run ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
