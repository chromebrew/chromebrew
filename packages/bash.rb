require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.8.tar.gz'
  source_sha256 '0cfb5c9bb1a29f800a97bd242d19511c997a1013815b805e0fdd32214113d6be'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.8_armv7l/bash-5.1.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.8_armv7l/bash-5.1.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.8_i686/bash-5.1.8-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.8_x86_64/bash-5.1.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4b34aa31012294bbafdfb392e986d2220bf95d3472302af3debb160491e44021',
     armv7l: '4b34aa31012294bbafdfb392e986d2220bf95d3472302af3debb160491e44021',
       i686: '449eed047e9cf2304a14560c596e2d0061a11b6782856bb0815dbd1127088462',
     x86_64: '8a63a3934b316589f590e5a68760cf928de1d563b075acb7b306a19a9cdb6c50'
  })

  case ARCH
  when 'i686'
    @CONFIGUREFLAGS = '--without-bash-malloc'
  when 'aarch64', 'armv7l', 'x86_64'
    @CONFIGUREFLAGS = '--with-bash-malloc'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} #{@CONFIGUREFLAGS} --with-curses --enable-readline \
      --enable-mem-scramble --enable-usg-echo-default \
      --enable-single-help-strings --enable-select \
      --enable-restricted --enable-progcomp --enable-process-substitution \
      --enable-net-redirections --enable-multibyte --enable-job-control \
      --enable-history --enable-help-builtin --enable-dparen-arithmetic \
      --enable-directory-stack --enable-coprocesses --enable-cond-regexp \
      --enable-cond-command --enable-command-timing --enable-casemod-expansions \
      --enable-casemod-attributes --enable-brace-expansion --enable-bang-history \
      --enable-array-variables --enable-arith-for-command --enable-alias"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashenv = <<~BASHEOF
      # Make Chromebrew's version of bash start automatically
      # This currently seems to be broken, uncomment at your own risk
      # #{CREW_PREFIX}/bin/bash
      # PS1=$PS1
    BASHEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash", @bashenv)
  end
end
