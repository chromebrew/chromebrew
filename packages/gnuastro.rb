require 'buildsystems/autotools'

class Gnuastro < Autotools
  description 'GNU Astronomy Utilities'
  homepage 'https://www.gnu.org/software/gnuastro/'
  version '0.21'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://ftp.gnu.org/gnu/gnuastro/gnuastro-0.21.tar.gz'
  source_sha256 '2fba993d8422391517b55f7eb511788946d7a886aa1584984fd4678bdd27537f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a70f5925ea2986d81c3e890dcf541ee6e3da7e7b53a561c571abe62285587977',
     armv7l: 'a70f5925ea2986d81c3e890dcf541ee6e3da7e7b53a561c571abe62285587977',
     x86_64: 'e35a00f1090c838434c114d6eb56055a8b51c4bd57b175646437cdbde2a99d7b'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'c_ares' # R
  depends_on 'cfitsio' # R
  depends_on 'curl' # R
  depends_on 'glibc' # R
  depends_on 'gsl' # R
  depends_on 'jbigkit' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libdeflate' # R
  depends_on 'libgit2'
  depends_on 'libidn2' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libtiff' # R
  depends_on 'libunistring' # R
  depends_on 'libwebp' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'wcslib' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R
end
