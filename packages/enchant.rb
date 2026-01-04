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
    aarch64: 'b018f45460b6535571d1abd8730ea9aa7ca0498d0f72160ecee1e39daa633045',
     armv7l: 'b018f45460b6535571d1abd8730ea9aa7ca0498d0f72160ecee1e39daa633045',
     x86_64: '61a3479cf176f05675df561e653b495610dcdcb43960128235c3622a5742f48a'
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
