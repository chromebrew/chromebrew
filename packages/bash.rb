require 'buildsystems/autotools'

class Bash < Autotools
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.3-rc2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/bash.git'
  # Bash patch commits aren't tagged or anything, although this commit does correspond to the patchlevel we're shipping.
  git_hashtag '102140e4c4301dfe9b5c38af59f2fc31465c9a76'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe9c9a584649f2c439af1dfbe7ca57e152f47499e95028cc2d2acea595650404',
     armv7l: 'fe9c9a584649f2c439af1dfbe7ca57e152f47499e95028cc2d2acea595650404',
       i686: '1e3e549e7cbeb9baca0f14e2938278ff9d7c1892bbf95b2ec1989d07a46d3e4d',
     x86_64: '89c1704c78ecfd7f6aacda3bad546fd7701e7c7b61522b87202017262a984a56'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  autotools_configure_options '--with-curses \
    --enable-extended-glob-default \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline'

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
end
