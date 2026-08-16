require 'buildsystems/autotools'

class Tig < Autotools
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'https://jonas.github.io/tig/'
  version '2.6.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/jonas/tig.git'
  git_hashtag "tig-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bf898b49971afcb3abfdbb0830174194c40b7fa950de10deddeecfd14ec7b04',
     armv7l: '6bf898b49971afcb3abfdbb0830174194c40b7fa950de10deddeecfd14ec7b04',
       i686: 'dff8603e36edd2344e3800a055ce8050850694430090b60dde2617c22a9a531d',
     x86_64: '9b23bfd4841045cbfd1962a842be9f02ca82ecb5d22080672ff055d2ee1efc24'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'readline' => :executable
end
