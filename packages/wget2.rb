require 'buildsystems/autotools'

class Wget2 < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.2.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/wget/wget2-#{version}.tar.gz"
  source_sha256 'agagag'
  # source_url 'https://gitlab.com/gnuwget/wget2.git'
  # git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcc35aa52125321e99fa293f99bff03c764ac36da3b48b921ed04dca1203fefb',
     armv7l: 'bcc35aa52125321e99fa293f99bff03c764ac36da3b48b921ed04dca1203fefb',
       i686: '94fd7df2890c9feb82f44e3d50363c45aa067c7a550e7335654e70db911c3f33',
     x86_64: '7fcbd974cec93c4161057f3b6743dc709fe624eb0de97dc1736f623d2369333b'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'ca_certificates' # L
  depends_on 'curl' => :build
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

  def self.patch
    # system './bootstrap'
    # system 'autoreconf -fiv'
  end

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
end
