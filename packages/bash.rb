require 'buildsystems/autotools'

class Bash < Autotools
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.3-rc1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/bash.git'
  # Bash patch commits aren't tagged or anything, although this commit does correspond to the patchlevel we're shipping.
  git_hashtag 'c8f067a9670dc2624cea3460d6d69489642044e9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f60506f37477c09a7ba92f87b73c0f3596416081063e5a5ce2ac4030e340f985',
     armv7l: 'f60506f37477c09a7ba92f87b73c0f3596416081063e5a5ce2ac4030e340f985',
       i686: '276849ade3ea250b4cc210b2ae011f18b377a16cae8302a579c5f88cc01c40c8',
     x86_64: 'c9b8d03bd023b7b328cf1e9d635db923b0c599cda53d5bb11b4be4db385c8461'
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
