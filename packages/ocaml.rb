require 'buildsystems/autotools'

class Ocaml < Autotools
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '5.4.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8eef941708e6de0b326c1939649b79f771166f61fd509d0f8604c121064b9af8',
     armv7l: '8eef941708e6de0b326c1939649b79f771166f61fd509d0f8604c121064b9af8',
       i686: 'b685ee5c735076fa41027038cac6b064cfd36427510a8c0a0c2ae5bb39be5d3a',
     x86_64: '555eec4b5de0b72124ee8f484d29834309a3284fe340971c60f7d6746b8b2838'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zstd' # R
end
