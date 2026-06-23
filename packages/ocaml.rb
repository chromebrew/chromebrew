require 'buildsystems/autotools'

class Ocaml < Autotools
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '5.5.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56d1fa4ba2ea85c3aa3e5743f75962b5a1b72506844d80dd3f734af103bb8dd6',
     armv7l: '56d1fa4ba2ea85c3aa3e5743f75962b5a1b72506844d80dd3f734af103bb8dd6',
       i686: '06e53e6a309eb41a24bf3ff52b66e7300230e82de06b7ef019bf4640c394f986',
     x86_64: '9d43188720a15e0767752dc6db2c831da25c050ee261f7794613d54fe1dc6b92'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zstd' => :library
end
