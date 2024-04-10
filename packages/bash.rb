require 'buildsystems/autotools'

class Bash < Autotools
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  @_ver = '5.2'
  @_patchlevel = 26
  version "#{@_ver}-#{@_patchlevel}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.2.tar.gz'
  source_sha256 'a139c166df7ff4471c5e0733051642ee5556c1cc8a4a78f145583c5c81ab32fb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a53c3392a334427b0381236789387217d8731e07f966d64b967ddf63cb60ba94',
     armv7l: 'a53c3392a334427b0381236789387217d8731e07f966d64b967ddf63cb60ba94',
       i686: 'ab4ccf3dbdea01b6cecbb5e28696f518e48a0bc38730060afad7b8e2d9724ce9',
     x86_64: '6c77b4a7cee18276a1b41807bfb6763626ac92bbfd6594422a4a9c3e3d9102c7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  def self.patch
    (1..@_patchlevel).each do |patch|
      patchfile = "bash52-#{patch.to_s.rjust(3, '0')}"
      downloader "https://mirrors.kernel.org/gnu/bash/bash-5.2-patches/#{patchfile}", 'SKIP'
      puts "Applying bash #{@_ver} patch #{patch}...".orange
      system "patch -Np0 -i #{patchfile}"
    end
  end

  configure_options '--with-curses \
    --enable-extended-glob-default \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
end
