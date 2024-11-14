require 'buildsystems/autotools'

class Bash < Autotools
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.2.37'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/bash.git'
  # Bash patch commits aren't tagged or anything, although this commit does correspond to the patchlevel we're shipping.
  git_hashtag 'c5c97b371044a44b701b6efa35984a3e1956344e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71baf69fae2defa31e9a03bf400af854e497a9da8c8e2897452ff7a6cb9d15c0',
     armv7l: '71baf69fae2defa31e9a03bf400af854e497a9da8c8e2897452ff7a6cb9d15c0',
       i686: '893182baaea3437535a1cf2dc3c49b477e1077bcabd0bfd2944a121ed10433fa',
     x86_64: '7d0e19d740cd7494b3eb36197917d2c1750c6568822d762f273374ca0d669bcb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  configure_options '--with-curses \
    --enable-extended-glob-default \
    --enable-readline \
    --without-bash-malloc \
    --with-installed-readline'

  configure_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
end
