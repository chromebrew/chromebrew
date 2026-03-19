require 'buildsystems/autotools'

class Procps < Autotools
  description 'procps is a set of command line and full-screen utilities that provide information out of the pseudo-filesystem most commonly located at /proc.'
  homepage 'https://gitlab.com/procps-ng/procps'
  version '4.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/procps-ng/procps.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3cb80317d20af10c73e660789f61b5ff183338d1ef05ef52a4895e92566b459',
     armv7l: 'c3cb80317d20af10c73e660789f61b5ff183338d1ef05ef52a4895e92566b459',
       i686: 'cf8e4fdcf65a83aaf4464233bc23139b354c9f40324b8f58f7b8ff09ddee94ef',
     x86_64: '3193c16555554d63bffe63957b6add1ab3f689bb8d5eb57f22533068fceb5605'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' => :executable

  conflicts_ok # Conflicts with uutils_coreutils.

  autotools_configure_options ('--disable-pidwait' if ARCH == 'i686').to_s
end
