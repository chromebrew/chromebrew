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
       i686: 'c1e0bce5e9d858e5d16107037a031e8e6b10d26f7e5eeb45ce2c8e0873a3f72a',
     x86_64: '637fa0913219b0072b6992176489c937784de2a9a95db29f20c9807d54d18f50'
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
