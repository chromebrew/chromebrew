require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version}.tar.xz"
  source_sha256 'f8c3486509de705192138b00ef2c00bbbdd0e84c30d5c07d23fc73a9dc4cc9cc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '154f49e5a9b9851c0301a98d16b94d962cb1f664c59e3f7d1750539c221efc6d',
     armv7l: '154f49e5a9b9851c0301a98d16b94d962cb1f664c59e3f7d1750539c221efc6d',
       i686: '71d84a28ad6d27b6a8c394592130fceaab5c7d4d62643daad9963aad6a129c58',
     x86_64: '177e43ad886fca0a2701f42564d5ff084ee0efa3a3fb85319405a869641335bf'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  no_shrink

  # Tests on i686 run out of memory.
  # Tests appear to have container issues on other platforms.
  # run_tests unless ARCH == 'i686'

  configure_options '--without-libsigsegv-prefix'

  configure_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
