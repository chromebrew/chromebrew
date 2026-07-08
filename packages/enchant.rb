require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.19'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17e5804504105e3a3839c75ddad0441058bbf10b9c93d7a0ffa95df0a89eca22',
     armv7l: '17e5804504105e3a3839c75ddad0441058bbf10b9c93d7a0ffa95df0a89eca22',
     x86_64: 'a7a321072b136de619dd96df1ddcec64b43e4a153b7dcd74a6960e06b42033f6'
  })

  depends_on 'aspell' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg'
  depends_on 'hunspell' => :logical
  depends_on 'hunspell_base' => :library
  depends_on 'ncurses' => :library
  depends_on 'vala' => :build

  autotools_configure_options '--with-hunspell \
        --with-aspell'
end
