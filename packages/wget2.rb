require 'buildsystems/autotools'

class Wget2 < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/wget/wget2-#{version}.tar.gz"
  source_sha256 '4f1915b2a55a789a15f2f9ada7cc44bca81418e648f76fd88a7f4dd028b2149f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcc35aa52125321e99fa293f99bff03c764ac36da3b48b921ed04dca1203fefb',
     armv7l: 'bcc35aa52125321e99fa293f99bff03c764ac36da3b48b921ed04dca1203fefb',
       i686: '94fd7df2890c9feb82f44e3d50363c45aa067c7a550e7335654e70db911c3f33',
     x86_64: '7fcbd974cec93c4161057f3b6743dc709fe624eb0de97dc1736f623d2369333b'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'ca_certificates' => :logical
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'gperf' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' => :build
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libtasn1' # R
  depends_on 'libunbound' # R
  depends_on 'libunistring' # R
  depends_on 'lzlib' # R
  depends_on 'nettle' # R
  depends_on 'openssl' # R
  depends_on 'p11kit' # R
  depends_on 'pcre2' # R
  depends_on 'util_linux' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_with 'wget_static'

  autotools_configure_options '--enable-year2038 \
                  --with-openssl=no \
                  --with-ssl=gnutls \
                  --without-libidn \
                  --with-bzip2 \
                  --with-lzma'

  autotools_install_extras do
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wget2", "#{CREW_DEST_PREFIX}/bin/wget"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/wget2_noinstall"
  end

  def self.patch
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
    patches = [
      # Fix for broken legacy TCP Fast Open code branch
      ['https://github.com/rockdaboot/wget2/commit/db600f40c51f0e612085f19351df3f9ad963bb5f.patch', '24b6928e87f388f633b51b98025c15ca6cd40c4cd388278cbb98bd06c64be719']
    ]
    ConvenienceFunctions.patch(patches) if ARCH == 'i686' && version == '2.3.0'
  end
end
