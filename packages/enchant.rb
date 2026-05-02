require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.16'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '002f837fe9b7d373cc95d1662ae2cf799c19bb87785d2600139555a2e80b7fb1',
     armv7l: '002f837fe9b7d373cc95d1662ae2cf799c19bb87785d2600139555a2e80b7fb1',
     x86_64: '3c1a033bf6f5969658d1cb5c206f2badffdb8740fa37c47f6aaea18b770cb4fe'
  })

  depends_on 'aspell' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnupg'
  depends_on 'hunspell' => :logical
  depends_on 'hunspell_base' => :library
  depends_on 'ncurses' => :library
  depends_on 'vala' => :build

  autotools_configure_options '--with-hunspell \
        --with-aspell'
end
