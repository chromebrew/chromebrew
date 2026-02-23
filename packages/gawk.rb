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
  version '5.4.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gawk/gawk-#{version.split('-').first}.tar.xz"
  source_sha256 '3dd430f0cd3b4428c6c3f6afc021b9cd3c1f8c93f7a688dc268ca428a90b4ac1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39196313d603083858c739cd39eb0ce65f16f08dc9a17aac1d11a29ba570520c',
     armv7l: '39196313d603083858c739cd39eb0ce65f16f08dc9a17aac1d11a29ba570520c',
       i686: '505f9fabf169629e8d219039c6493257471e4ecc1da17e7741a5a9699f530b5c',
     x86_64: 'f792967a6c06e7ea70b1eb05c4fa68fa2ae6d9bc7876552f33a50a25fcb18523'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' => :executable_only

  # Tests appear to have container issues...
  # run_tests unless ARCH == 'i686' || ARCH == 'x86_64'

  autotools_configure_options '--without-libsigsegv-prefix'

  autotools_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end

  def self.patch
    # Fix automake 1.16 requirements.
    system 'grep -rlZ AM_INIT_AUTOMAKE . | xargs -0 sed -i \'s,1.16,1.18,g\''
    system 'grep -rlZ aclocal . | xargs -0 sed -i \'s,1.16,1.18,g\''
  end
end
