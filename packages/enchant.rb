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
    aarch64: '846bb508818e766cf7bb7a5ade20167f6fff9abfbbd1a843a6a9a6c7072c1ca4',
     armv7l: '846bb508818e766cf7bb7a5ade20167f6fff9abfbbd1a843a6a9a6c7072c1ca4',
     x86_64: '78e9a439493adbf71fb20f382aa8970ca07704e9dead1be36cbb9767ec449c56'
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
