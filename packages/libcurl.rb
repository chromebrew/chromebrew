require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.84.0'
  version @_ver.to_s
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '2d118b43f547bfe5bae806d8d47b4e596ea5b25a6c1f080aef49fbcd817c5db8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.84.0_armv7l/libcurl-7.84.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.84.0_armv7l/libcurl-7.84.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.84.0_i686/libcurl-7.84.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.84.0_x86_64/libcurl-7.84.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e218858ab99411d1a5c5d98206350c9beb6c34f0ccee3850033345411d7fc7d8',
     armv7l: 'e218858ab99411d1a5c5d98206350c9beb6c34f0ccee3850033345411d7fc7d8',
       i686: '05bfd4cd3d02987e3f6f45b9b069002679d097c3547f0b9b370b7ab60b2c9ef7',
     x86_64: '58773af98bf5db2ea628e438989e5bd5ccece887117c3c0f978e2ea8d551d212'
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
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

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
