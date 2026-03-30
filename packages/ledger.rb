require 'buildsystems/cmake'

class Ledger < CMake
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://ledger-cli.org/'
  version '3.4.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/ledger/ledger.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '735cea24777755df15458f1a8d7e0caaee5378e73d5f54bf1ae4af7d56e3e07a',
     armv7l: '735cea24777755df15458f1a8d7e0caaee5378e73d5f54bf1ae4af7d56e3e07a',
       i686: 'bf34721b05ff54338a43b4b017858d959036aad1a71d406767aa7860fd9a0bbd',
     x86_64: 'a73f6db4aed788bd314c13ac8c4fe41d2b55f3ce8a6f45effb3e24552a54a196'
  })

  depends_on 'boost' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gmp' => :library
  depends_on 'libedit' => :library
  depends_on 'mpfr' => :library
end
