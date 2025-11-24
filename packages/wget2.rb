require 'buildsystems/autotools'

class Wget2 < Autotools
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '2.2.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/gnuwget/wget2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09e08370f029c62c46d1b5c1e308d77a9b195891e350c887252e1dc79b2380be',
     armv7l: '09e08370f029c62c46d1b5c1e308d77a9b195891e350c887252e1dc79b2380be',
       i686: 'fcb9cf5a798decde6d27134fe90e982668147a3aceeae56e917544bb3728c08d',
     x86_64: '7f1da024c4e1d6c8492906e1bcb9fcf627ec283b12c477e7c84d8e5ded28b886'
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wget2", "#{CREW_DEST_PREFIX}/bin/wget"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/wget2_noinstall"
  end
end
