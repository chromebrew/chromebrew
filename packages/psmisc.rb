require 'buildsystems/autotools'

class Psmisc < Autotools
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  version '23.7-252db9b'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/psmisc/psmisc.git'
  git_hashtag '252db9b91d0cdbc4bbdbd8c645f7df30235dc36f'
  # source_url "https://gitlab.com/psmisc/psmisc/-/archive/v#{version}/psmisc-v#{version}.tar.bz2"
  # source_sha256 'c4b1df2e671e8194f6c3063e43cb9afa26cbe9859f1026ff6ad258ac562804f4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
     armv7l: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
       i686: '5e291a92be499d81f802d75031443397eb2f3d52b0672142110e58c873107a8c',
     x86_64: '29a2b3ed12ece0f873cf335f6bcf5ace47a10ffe26e7582cde0ab451c07c8532'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  no_lto unless ARCH == 'x86_64'

  autotools_pre_configure_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"
  autotools_configure_options '--disable-statx'
end
