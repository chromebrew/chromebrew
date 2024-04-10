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
    aarch64: '491cec8a98cdaf51555e132501a12aefb747b1055af4d4ca79571c441978bb55',
     armv7l: '491cec8a98cdaf51555e132501a12aefb747b1055af4d4ca79571c441978bb55',
       i686: 'ed8867045a27edb51582bf20fee3060fc75fc3f2d49237b9a729084793400829',
     x86_64: 'a0aec6a5f64365b174f8d6834a7dfbb50073bed90da42ded7e0bfb4cb843522d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  def self.patch
    (1..@_patchlevel).each do |patch|
      patchfile = "bash52-#{patch.to_s.rjust(3, '0')}"
      downloader "https://mirrors.kernel.org/gnu/bash/bash-5.2-patches/#{patchfile}", 'SKIP'
      system "patch -Np0 -i #{patchfile}"
    end
  end

  configure_options '--with-curses \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
end
