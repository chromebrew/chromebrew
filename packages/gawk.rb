require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.3.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version}.tar.xz"
  source_sha256 '694db764812a6236423d4ff40ceb7b6c4c441301b72ad502bb5c27e00cd56f78'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2fd73496950cf2482815e4fb21a0e652f0b726be8fc5f7f16009d7dd3df2faa0',
     armv7l: '2fd73496950cf2482815e4fb21a0e652f0b726be8fc5f7f16009d7dd3df2faa0',
       i686: '71d84a28ad6d27b6a8c394592130fceaab5c7d4d62643daad9963aad6a129c58',
     x86_64: '177e43ad886fca0a2701f42564d5ff084ee0efa3a3fb85319405a869641335bf'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  # Tests on i686 run out of memory.
  run_tests unless ARCH == 'i686'

  configure_options '--without-libsigsegv-prefix'

  configure_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
