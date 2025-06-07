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
    version '5.3.0-2'
  else
    version '5.3.2-1'
  end
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'i686'
    # The Savannah git server keeps throwing 502 errors.
    source_url 'https://github.com/sailfishos-mirror/gawk/archive/605a77387523a07e3636d3a72c7a612dc15a5b31.tar.gz'
    source_sha256 '13c7e7f70c16ee158d8808b787ec5c9164faf1a08f1a7d7b3d937c5556f7f7eb'
  else
    source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version.split('-').first}.tar.xz"
    source_sha256 'f8c3486509de705192138b00ef2c00bbbdd0e84c30d5c07d23fc73a9dc4cc9cc'
  end
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
     armv7l: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
       i686: '9e9fda3c7e8dd393fa4bb389910192e1d2c480dc8372139e129e8bd6f940d56d',
     x86_64: '45cd418bd240b9e23741907ca11794657eaf3b2fad88283d5d193ac2e3149dbb'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  no_shrink

  # Tests appear to have container issues...
  run_tests unless ARCH == 'i686' || ARCH == 'x86_64'

  autotools_configure_options '--without-libsigsegv-prefix'

  autotools_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
