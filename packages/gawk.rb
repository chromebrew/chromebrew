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
  version '5.4.1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gawk/gawk-#{version}.tar.xz"
  source_sha256 '07f6f7342b7febe4313fc2c2542ad93d64fe20ad8717200109f105a826f5fd37'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c30d9e452953d665054097dc95ae8188e9cb55f505204a4bdf342e0345db5900',
     armv7l: 'c30d9e452953d665054097dc95ae8188e9cb55f505204a4bdf342e0345db5900',
       i686: '3de4da5662976cc645124368c89c4b8fbcc11de4e5bd468dbcb3f2b2f5d67606',
     x86_64: '90a700d3615944895f969045683faa375cb99c2f6c3dfb3fd09b54dba1405940'
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
