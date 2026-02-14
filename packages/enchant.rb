require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.15'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '357dcd8795341598c0be34cabfa260696e9717c74f7939d22e70ecd5d13e1706',
     armv7l: '357dcd8795341598c0be34cabfa260696e9717c74f7939d22e70ecd5d13e1706',
     x86_64: 'f26d177a7865397f86172cc6e434f9a143cf56c7b59dfb617fbe4d1c6ff0b41d'
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
