require 'buildsystems/cmake'

class Codelite < CMake
  description 'CodeLite is an open source, free, cross platform IDE, specialized in C, C++, Rust, Python, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '18.1.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/eranif/codelite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ce2928e3a9d72d9a46c90260a6d5b4396913dcdb02a7c8342acebeb5db5c9e0',
     armv7l: '3ce2928e3a9d72d9a46c90260a6d5b4396913dcdb02a7c8342acebeb5db5c9e0',
     x86_64: '8a3cb05597521854499fd7f69287ed82a68853a11bda85621c16456b1dc1c081'
  })

  depends_on 'libedit'
  depends_on 'libssh'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
end
