require 'buildsystems/autotools'

class Wget < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/wget/wget2-2.1.0.tar.lz'
  source_sha256 'bc034194b512bb83ce0171d15a8db33e1c5c3ab8b3e343e1e6f2cf48f9154fad'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/2.1.0_armv7l/wget-2.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/2.1.0_armv7l/wget-2.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/2.1.0_i686/wget-2.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/2.1.0_x86_64/wget-2.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6b46a66939b3617d8f456fed4912d0922995817ca47ea200cab7091227c271c1',
     armv7l: '6b46a66939b3617d8f456fed4912d0922995817ca47ea200cab7091227c271c1',
       i686: '5410ba3e2077936cb1274aefac15de8043171540d7be043c7af92e7ac7d58a92',
     x86_64: '140c6971bbd263cc9a0d8286bfcf764c1fe6d7ac7c49e8ad0524043fcf57bbbf'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gperf' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' => :build
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'lzlib' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'util_linux' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  configure_options '--with-ssl=openssl'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wget2", "#{CREW_DEST_PREFIX}/bin/wget"
  end
end
