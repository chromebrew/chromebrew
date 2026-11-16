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
  version '5.4.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gawk/gawk-#{version}.tar.xz"
  source_sha256 'b95e4909533b5f988c6b5e5539b3b3ddf76e7d7df02ca2e5b5b7d6f62db78e6a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28668b3670a65301aaafad05a3ca98eb8dcb7f35a281fb9e51548d18a0ec8ad7',
     armv7l: '28668b3670a65301aaafad05a3ca98eb8dcb7f35a281fb9e51548d18a0ec8ad7',
       i686: '0dbe2b0db1b71dec414a2fe0f5ce3472f505d038bdbac7efbc6e6bdec96de529',
     x86_64: '0f0e1a13be4442316b78faf0009aed91414563921cbdd302025eb47cb3d2a9b7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' => :library
  depends_on 'ncurses' => :build
  depends_on 'readline' => :executable

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
