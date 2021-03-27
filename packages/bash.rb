require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1-1-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.tar.gz'
  source_sha256 'cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa'

  depends_on 'llvm' => :build # Needed only for lld, which appears to allow linking libiconv where ld does not.
  depends_on 'ncurses' => :build # A static enabled ncurses build w/o "--without-normal" is required to build.

  case ARCH
  when 'i686'
  @CONFIGUREFLAGS = '--without-bash-malloc'
  when 'aarch64','armv7l','x86_64'
  @CONFIGUREFLAGS = '--with-bash-malloc'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} #{@CONFIGUREFLAGS} --with-curses --enable-readline \
      --enable-mem-scramble --enable-usg-echo-default \
      --enable-single-help-strings --enable-select \
      --enable-restricted --enable-progcomp --enable-process-substitution \
      --enable-net-redirections --enable-multibyte --enable-job-control \
      --enable-history --enable-help-builtin --enable-dparen-arithmetic \
      --enable-directory-stack --enable-coprocesses --enable-cond-regexp \
      --enable-cond-command --enable-command-timing --enable-casemod-expansions \
      --enable-casemod-attributes --enable-brace-expansion --enable-bang-history \
      --enable-array-variables --enable-arith-for-command --enable-alias \
      --enable-static-link"
    system 'make'
  end

  def self.install
     system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
     FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"

     FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
     @env = <<~EOF
       # Make Chromebrew's version of bash start automatically
       # This currently seems to be broken, uncomment at your own risk
       # #{CREW_PREFIX}/bin/bash
       # PS1=$PS1
     EOF
     IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash", @env)
  end
end
