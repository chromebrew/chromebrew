require 'package'

class Bash < Package
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.2-2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.2.tar.gz'
  source_sha256 'a139c166df7ff4471c5e0733051642ee5556c1cc8a4a78f145583c5c81ab32fb'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-2_armv7l/bash-5.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-2_armv7l/bash-5.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-2_i686/bash-5.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bash/5.2-2_x86_64/bash-5.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5167feed4d0bfc86b1b13ea87eadf4167bdd879122ad1c113002fc367a5db57e',
     armv7l: '5167feed4d0bfc86b1b13ea87eadf4167bdd879122ad1c113002fc367a5db57e',
       i686: '9454bcfda1d88307a80c00f68e9a5294c29331ffdf3c6f951385faef3cd5ffb5',
     x86_64: 'a777bad1a9ce382c07e73e192c48063baa481c53ef78bf5e74c32aeb60b9eefd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

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
  end
end
