require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1.16'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/bash/bash-5.1.16.tar.gz'
  source_sha256 '5bac17218d3911834520dad13cd1f85ab944e1c09ae1aba55906be1f8192f558'

  case ARCH
  when 'i686'
    @CONFIGUREFLAGS = '--without-bash-malloc'
  when 'aarch64', 'armv7l', 'x86_64'
    @CONFIGUREFLAGS = '--with-bash-malloc'
  end

  def self.build
    system <<~BUILD
      #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} #{@CONFIGUREFLAGS} \
        --with-curses --enable-readline \
        --enable-mem-scramble --enable-usg-echo-default \
        --enable-single-help-strings --enable-select \
        --enable-restricted --enable-progcomp --enable-process-substitution \
        --enable-net-redirections --enable-multibyte --enable-job-control \
        --enable-history --enable-help-builtin --enable-dparen-arithmetic \
        --enable-directory-stack --enable-coprocesses --enable-cond-regexp \
        --enable-cond-command --enable-command-timing --enable-casemod-expansions \
        --enable-casemod-attributes --enable-brace-expansion --enable-bang-history \
        --enable-array-variables --enable-arith-for-command --enable-alias
    BUILD

    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashenv = <<~BASHEOF
      # Make Chromebrew's version of bash start automatically
      if [[ "$(coreutils --coreutils-prog=readlink "/proc/$$/exe")" != '#{CREW_PREFIX}/bin/bash' ]]; then
        exec #{CREW_PREFIX}/bin/bash
      fi
    BASHEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash", @bashenv)
  end
end
