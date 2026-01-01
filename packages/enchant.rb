require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.14'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83ea7932891bf59f10c678ba042060eaac965bf511a8f31bfbc4a312d0e15c0e',
     armv7l: '83ea7932891bf59f10c678ba042060eaac965bf511a8f31bfbc4a312d0e15c0e',
     x86_64: '73db9b0d09602b4d48c9833ea80c9608b096e435e8760c883d24fc5bcb0a5f98'
  })

  depends_on 'aspell' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnupg'
  depends_on 'hunspell' # L
  depends_on 'hunspell_base' # R
  depends_on 'ncurses' # R
  depends_on 'vala' => :build

  autotools_configure_options '--with-hunspell \
        --with-aspell'
end
