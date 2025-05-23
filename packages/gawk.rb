# This uses the last commit before f346791bba5d53a516571e9826805d884097a1fa
# for i686 (as per the sailfish gawk mirror).
# Date: Thu, 21 Dec 2023 13:10:37 +0200
# Subject: [PATCH] Attempt to close SIGPIPE race condition.
# 00b12818868cc7546817536cf33dcc4f440810a
# Originally in 5.3.1, which appears to cause an out of memory
# issue on i686, especially when building glibc.
require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  case ARCH
  when 'i686'
    version '5.3.0-1'
  else
    version '5.3.2'
  end
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'i686'
    # The Savannah git server keeps throwing 502 errors.
    source_url 'https://github.com/sailfishos-mirror/gawk/archive/605a77387523a07e3636d3a72c7a612dc15a5b31.tar.gz'
    source_sha256 'f8c3486509de70519asas'
  else
    source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version.split('-').first}.tar.xz"
    source_sha256 'f8c3486509de705192138b00ef2c00bbbdd0e84c30d5c07d23fc73a9dc4cc9cc'
  end
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '154f49e5a9b9851c0301a98d16b94d962cb1f664c59e3f7d1750539c221efc6d',
     armv7l: '154f49e5a9b9851c0301a98d16b94d962cb1f664c59e3f7d1750539c221efc6d',
       i686: '1581fef815f82fbed1d986f9e668aeb329ef28ac42cbc22c347d5715ec03e18a',
     x86_64: '637fa0913219b0072b6992176489c937784de2a9a95db29f20c9807d54d18f50'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  no_shrink

  # Tests appear to have container issues...
  run_tests if ARCH == 'i686'

  autotools_configure_options '--without-libsigsegv-prefix'

  autotools_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
