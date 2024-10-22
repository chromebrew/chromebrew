require 'buildsystems/autotools'

class Bash < Autotools
  description 'The GNU Bourne Again SHell is a Bourne-compatible shell with useful csh and ksh features.'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.2.32'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/bash.git'
  # Bash patch commits aren't tagged or anything, although this commit does correspond to the patchlevel we're shipping.
  git_hashtag '142bbdd89e4d5bb62aea4469d1d2c24cf470afd8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '215c9201d6fcb93cf547fe8992c0d2d912c3d5b4de77530e99fc22847d02cdfa',
     armv7l: '215c9201d6fcb93cf547fe8992c0d2d912c3d5b4de77530e99fc22847d02cdfa',
       i686: '39ab8b278ffc655f1b89f971443ddbeaded91a7de8200291954f04bb2c89a474',
     x86_64: 'baddfe839daa9d6741c82cc2e0494196d28bbfda8171c9f8486ccee33df0f364'
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
