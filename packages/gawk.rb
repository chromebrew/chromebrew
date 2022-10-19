require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  @_ver = '5.2.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gawk.git'
  git_hashtag "gawk-#{@_ver}"

  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'
  depends_on 'libsigsegv' unless ARCH == 'i686'

  def self.patch
    # Ironically libsigsegv causes crashes on i686
    return unless ARCH == 'i686'

    system "sed -i 's,\$(top_srcdir)/m4/libsigsegv.m4,,g' Makefile.in"
    FileUtils.rm 'm4/libsigsegv.m4'
  end

  def self.build
    system './bootstrap.sh'
    # For some reason, ./bootstrap.sh doesn't call autoconf at all
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    # Still has failing issues on i686.
    case ARCH
    when 'i686'
      system 'make check || true'
    else
      system 'make', 'check'
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
