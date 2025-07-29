# gawk will break in docker containers in certain situations.
# Add  --ulimit "nofile=$(ulimit -Sn):$(ulimit -Hn)" to work around
# this docker issue that breaks gawk on 32-bit containers:
# https://zouyee.medium.com/why-does-rlimit-nofile-slow-down-your-containerized-application-in-2024-3361671ef5e8
# https://github.com/containerd/containerd/pull/7566#issuecomment-1285417325
# https://github.com/containerd/containerd/pull/7566#issuecomment-1461134737

require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.3.2-1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version.split('-').first}.tar.xz"
  source_sha256 'ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
     armv7l: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
       i686: 'ade3834e052404023c02f4a7e8fb6d281c1d0e1f73c442e54b14015a7ee513f7',
     x86_64: '45cd418bd240b9e23741907ca11794657eaf3b2fad88283d5d193ac2e3149dbb'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  # Tests appear to have container issues...
  # run_tests unless ARCH == 'i686' || ARCH == 'x86_64'

  autotools_configure_options '--without-libsigsegv-prefix'

  autotools_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end

  def self.patch
    # Fix automake 1.16 requirements.
    system 'grep -rlZ AM_INIT_AUTOMAKE . | xargs -0 sed -i \'s,1.16,1.18,g\'' unless ARCH == 'x86_64'
    system 'grep -rlZ aclocal . | xargs -0 sed -i \'s,1.16,1.18,g\'' unless ARCH == 'x86_64'
  end
end
