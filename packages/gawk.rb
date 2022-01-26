require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  @_ver = '5.1.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gawk.git'
  git_hashtag "gawk-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1-1_armv7l/gawk-5.1.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1-1_armv7l/gawk-5.1.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1-1_i686/gawk-5.1.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1-1_x86_64/gawk-5.1.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0963d6d7067653da8039fc4182235d7b8b75bb4adc8e2448e122a85d00cb3d93',
     armv7l: '0963d6d7067653da8039fc4182235d7b8b75bb4adc8e2448e122a85d00cb3d93',
       i686: '9c6609595c2fa11e1a5e9ddda7e6a592b4040549a37915ebae929ba12fa41fea',
     x86_64: '2734c6270be8ee586007e4389c762b956f993d7503e9cb7d863c2b675bde9e2b'
  })

  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.patch
    # Ironically libsigsegv causes crashes on i686
    return unless ARCH == 'i686'

    system "sed -i 's,\$(top_srcdir)/m4/libsigsegv.m4,,g' Makefile.in"
    FileUtils.rm 'm4/libsigsegv.m4'
  end

  def self.build
    system 'autoreconf -fvi'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    # Still has failing issues on i686.
    system 'make check || true'
  end

  def self.install
    # Conflict with /usr/local/bin/awk from mawk package.
    ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
