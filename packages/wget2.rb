require 'buildsystems/autotools'

class Wget2 < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wget/wget2-2.1.0.tar.lz'
  source_sha256 'bc034194b512bb83ce0171d15a8db33e1c5c3ab8b3e343e1e6f2cf48f9154fad'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09e08370f029c62c46d1b5c1e308d77a9b195891e350c887252e1dc79b2380be',
     armv7l: '09e08370f029c62c46d1b5c1e308d77a9b195891e350c887252e1dc79b2380be',
       i686: '3f1890cd75d06060a4cbc6c7abe5ab1f8ebdfade7fc9fcc899078eb27b396d32',
     x86_64: '7f1da024c4e1d6c8492906e1bcb9fcf627ec283b12c477e7c84d8e5ded28b886'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'ca_certificates' # L
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gperf' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' => :build
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'lzlib' # R
  depends_on 'pcre2' # R
  depends_on 'util_linux' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  configure_options '--enable-year2038 \
                  --with-openssl=no \
                  --with-ssl=gnutls \
                  --without-libidn \
                  --with-bzip2 \
                  --with-lzma'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wget2", "#{CREW_DEST_PREFIX}/bin/wget"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/wget2_noinstall"
  end
end
