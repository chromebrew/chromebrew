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
    aarch64: '68874477d0d746481ac31a2af585ab8e35b8d788ce41914f1268bc92ed86e09a',
     armv7l: '68874477d0d746481ac31a2af585ab8e35b8d788ce41914f1268bc92ed86e09a',
       i686: '927f2ab0a6affa680a3bc2915f1a0034e53b90caee0963ef9e74e88dcb3ad319',
     x86_64: 'ea7e4870d0fe46eaf2f16a5bd611ffd489e69be7c7a020f2b343632aeeba4ec6'
  })

  depends_on 'brotli' => :library
  depends_on 'bzip2' => :library
  depends_on 'ca_certificates' => :logical
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :library
  depends_on 'gperf' => :build
  depends_on 'libidn2' => :library
  depends_on 'libmetalink' => :build
  depends_on 'libnghttp2' => :library
  depends_on 'libpsl' => :library
  depends_on 'libtasn1' => :executable
  depends_on 'libunbound' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'lzlib' => :library
  depends_on 'nettle' => :executable
  depends_on 'openssl' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'pcre2' => :library
  depends_on 'util_linux' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

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
