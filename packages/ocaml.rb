require 'buildsystems/autotools'

class Ocaml < Autotools
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '5.4.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb10cfb987e6f63ce2308c9de6d7206a3fac01ff72ef3447b194f4f9098d5a4b',
     armv7l: 'eb10cfb987e6f63ce2308c9de6d7206a3fac01ff72ef3447b194f4f9098d5a4b',
       i686: 'ce8d7c0aba087176113f77088642559b668ec578be5a0bb7cb67f86c9b3d66e0',
     x86_64: 'edd6007b3e73623075492a7b7913d9fda9646ee5dd35192a2aceaa47bb74778b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zstd' # R
end
