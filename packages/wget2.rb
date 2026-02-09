require 'buildsystems/autotools'

class Wget2 < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.2.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/gnuwget/wget2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e721c5fc826a29487a21bff10b9af2a5f06ceb6208ab6b9431e9ca644b8ecf12',
     armv7l: 'e721c5fc826a29487a21bff10b9af2a5f06ceb6208ab6b9431e9ca644b8ecf12',
       i686: 'fcb9cf5a798decde6d27134fe90e982668147a3aceeae56e917544bb3728c08d',
     x86_64: '1ed2ba8aeec518c368870e00644706891d973a68267c6b2ce4fb0fc37521cbbf'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'ca_certificates' # L
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

  autotools_configure_options '--enable-year2038 \
                  --with-openssl=no \
                  --with-ssl=gnutls \
                  --without-libidn \
                  --with-bzip2 \
                  --with-lzma'

  def self.patch
    # Patch needed due to failure of gettext detection
    # when 'autoreconf -fvi' invokes autopoint.
    File.write 'gettext.patch', <<~GETTEXT_PATCH_EOF
      diff -Npaur a/configure.ac b/configure.ac
      --- a/configure.ac	2025-11-24 16:32:01.716022174 -0500
      +++ b/configure.ac	2025-11-24 16:33:02.520730059 -0500
      @@ -417,10 +417,6 @@ m4_ifdef([AM_GNU_GETTEXT], [
       ], [
         have_po=no
       ])
      -m4_ifdef([AM_GNU_GETTEXT_VERSION], [
      -#do not indent here
      -AM_GNU_GETTEXT_VERSION([0.21])
      -])
       AM_CONDITIONAL([HAVE_PO], [ test "$have_po" = "yes" ])
    GETTEXT_PATCH_EOF
    system 'patch -Np1 -i gettext.patch'
    system './bootstrap'
    system 'autoreconf -fiv'
  end

  autotools_install_extras do
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wget2", "#{CREW_DEST_PREFIX}/bin/wget"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/wget2_noinstall"
  end
end
