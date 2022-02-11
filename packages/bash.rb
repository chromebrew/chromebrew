require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1.16'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.16.tar.gz'
  source_sha256 '5bac17218d3911834520dad13cd1f85ab944e1c09ae1aba55906be1f8192f558'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.16_armv7l/bash-5.1.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.16_armv7l/bash-5.1.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.16_i686/bash-5.1.16-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.1.16_x86_64/bash-5.1.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e81f33f36736aeba1d48ddffcc626dc0c9732cea529283e7c0abc80964c45641',
     armv7l: 'e81f33f36736aeba1d48ddffcc626dc0c9732cea529283e7c0abc80964c45641',
       i686: '0b1d3b6f3a6ca41e28bddf1838edd26fdacc20aa7f8ab4085665931247db7660',
     x86_64: 'd92e0f2a8b44e93c6d6869a074039b74f7a4295583b8497637f058de56a28d32'
  })

  depends_on 'mimalloc' => :build if ARCH == 'i686'
  no_env_options

  def self.build
    case ARCH
    when 'i686'
      @configure_flags = '--without-bash-malloc'
      # Use mimalloc since it is better than an OLD malloc from an old
      # glibc
      @bash_env_options = CREW_ENV_OPTIONS.gsub('LDFLAGS="',
                                                "LDFLAGS=\"#{CREW_LIB_PREFIX}/libmimalloc.a ")
    when 'aarch64', 'armv7l', 'x86_64'
      @configure_flags = '--with-bash-malloc'
      @bash_env_options = CREW_ENV_OPTIONS
    end
    puts @bash_env_options.lightblue
    system <<~BUILD
      #{@bash_env_options} ./configure #{CREW_OPTIONS} #{@configure_flags} \
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
