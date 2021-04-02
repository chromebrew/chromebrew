require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1-1-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.tar.gz'
  source_sha256 'cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '72fd49fb8fcc718587e71df1df7eb69812fab5ae2e5706a3093254af2f44b8ec',
     armv7l: '72fd49fb8fcc718587e71df1df7eb69812fab5ae2e5706a3093254af2f44b8ec',
       i686: 'aebd997e7f52bd91b3aa62cffc07dd613f4900be075f4ca093f15be13e388d17',
     x86_64: '232cd95a5feda0c9c7dc6bbcf6015d8b60ffcb760215d7aad1d6ac8bba11316e'
  })

  case ARCH
  when 'i686'
    @CONFIGUREFLAGS = '--without-bash-malloc'
  when 'aarch64', 'armv7l', 'x86_64'
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
