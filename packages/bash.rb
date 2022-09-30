require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.2-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.2.tar.gz'
  source_sha256 'a139c166df7ff4471c5e0733051642ee5556c1cc8a4a78f145583c5c81ab32fb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-1_armv7l/bash-5.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-1_armv7l/bash-5.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-1_i686/bash-5.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-1_x86_64/bash-5.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '06b11b54021d3aed9765959a7bb11d062c1fa5df454ce617dffdc0be9e9bab8f',
     armv7l: '06b11b54021d3aed9765959a7bb11d062c1fa5df454ce617dffdc0be9e9bab8f',
       i686: '30949988b5b75a3db5e0d33385a470e434b0b4cc584c837f9380cd5af4c489c8',
     x86_64: '897db36a9bc15c296d519a77af77d0dee125f17a72dc923031a11910c3afd880'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
        --enable-alias\
        --enable-arith-for-command \
        --enable-array-variables \
        --enable-bang-history \
        --enable-brace-expansion \
        --enable-casemod-attributes \
        --enable-casemod-expansions \
        --enable-command-timing \
        --enable-cond-command \
        --enable-cond-regexp \
        --enable-coprocesses \
        --enable-directory-stack \
        --enable-dparen-arithmetic \
        --enable-help-builtin \
        --enable-history \
        --enable-job-control \
        --enable-mem-scramble \
        --enable-multibyte \
        --enable-net-redirections \
        --enable-process-substitution \
        --enable-progcomp \
        --enable-readline \
        --enable-restricted \
        --enable-select \
        --enable-single-help-strings \
        --enable-usg-echo-default \
        --with-bash-malloc \
        --with-curses"

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
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash", @bashenv)
  end
end
