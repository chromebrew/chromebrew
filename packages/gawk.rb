# This uses the last commit before f346791bba5d53a516571e9826805d884097a1fa
# for i686 (as per the sailfish gawk mirror).
# Date: Thu, 21 Dec 2023 13:10:37 +0200
# Subject: [PATCH] Attempt to close SIGPIPE race condition.
# 00b12818868cc7546817536cf33dcc4f440810a
# Originally in 5.3.1, which appears to cause an out of memory
# issue on i686 & armv7l, especially when building glibc.
require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  case ARCH
  when 'x86_64'
    version '5.3.2-1'
  when 'i686'
    version '5.3.0-2'
  when 'armv7l', 'aarch64'
    version '5.3.2-16ba211'
  end
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'x86_64' 
    source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version.split('-').first}.tar.xz"
    source_sha256 'ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b'
  when 'i686'
    # The Savannah git server keeps throwing 502 errors.
    source_url 'https://github.com/sailfishos-mirror/gawk/archive/605a77387523a07e3636d3a72c7a612dc15a5b31.tar.gz'
    source_sha256 '13c7e7f70c16ee158d8808b787ec5c9164faf1a08f1a7d7b3d937c5556f7f7eb'
  when 'armv7l', 'aarch64'
    source_url 'https://github.com/sailfishos-mirror/gawk/archive/16ba2113002eedad16b944cac3439eb309648144.tar.gz'
    source_sha256 '5a0c27d2afb79b025b7e2632c8acbd864f5eca5e72852b8bf76f9db6348b0b86'
  end
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53aa280d0002e31149f465fa680015bfc83a02bcde09285af45642b8a99bbc22',
     armv7l: '53aa280d0002e31149f465fa680015bfc83a02bcde09285af45642b8a99bbc22',
       i686: '9e9fda3c7e8dd393fa4bb389910192e1d2c480dc8372139e129e8bd6f940d56d',
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
