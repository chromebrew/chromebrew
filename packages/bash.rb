require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.2.tar.gz'
  source_sha256 'a139c166df7ff4471c5e0733051642ee5556c1cc8a4a78f145583c5c81ab32fb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2_armv7l/bash-5.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2_armv7l/bash-5.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2_i686/bash-5.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2_x86_64/bash-5.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e6bfc3b8744f2eca36531b74ff9b0c12c6f0c6cfb2ac767095cadc93c00223e4',
     armv7l: 'e6bfc3b8744f2eca36531b74ff9b0c12c6f0c6cfb2ac767095cadc93c00223e4',
       i686: '1e267103627dc708ccbd7ca767fede6e2dce0f972ab0bb1b42059045836ceb9f',
     x86_64: 'b3c92bb0d63a5dbbea804123932faec289e9e560b8f2224a34c958f7fd9d87c3'
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
