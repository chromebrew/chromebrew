require 'buildsystems/autotools'

class Psmisc < Autotools
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  version '23.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/psmisc/psmisc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
     armv7l: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
       i686: 'f833aae432564a90811d6196b0353ddeca6a3c818532d05fd161731deb3d960d',
     x86_64: '29a2b3ed12ece0f873cf335f6bcf5ace47a10ffe26e7582cde0ab451c07c8532'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'patchutils' => :build

  autotools_pre_configure_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"

  def self.patch
    # See https://gitlab.com/psmisc/psmisc/-/issues/48
    # and also https://gitlab.com/psmisc/psmisc/-/issues/61
    downloader 'https://gitlab.com/psmisc/psmisc/-/commit/c22d1e4edbfec6e24346cd8d89b822cb07cd6f5c.patch', 'aaaaaa', 'statx.patch'
    system 'interdiff -q statx.patch /dev/null > statx_reversed.patch'
    system 'patch -Np1 -i statx_reversed.patch'
  end
end
