require 'buildsystems/autotools'

class Enchant < Autotools
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.8.17'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AbiWord/enchant.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c71c7026dee534ddb4070369ae20d4ae4668f8ba40166a16523c5a4179c0f2a',
     armv7l: '0c71c7026dee534ddb4070369ae20d4ae4668f8ba40166a16523c5a4179c0f2a',
     x86_64: '2e3888709cd7f99ce51b04794eb50ae0089a007ed24633519eda4bd3806b5655'
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
