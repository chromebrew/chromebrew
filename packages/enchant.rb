require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.21'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30aae32a81999c50a5bde335b97bd65d717340af69814e5022598e765f8fa1c8',
     armv7l: '30aae32a81999c50a5bde335b97bd65d717340af69814e5022598e765f8fa1c8',
     x86_64: 'b1c8ffab2625ffdb138caaf5790f6220c0e335136e4c0035c39694865c5f5ce1'
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
