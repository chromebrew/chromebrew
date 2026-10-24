require 'buildsystems/autotools'

class Ocaml < Autotools
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '5.5.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf7f4e7c05d2c555c5a2c7fc99d55e2e317ac18873a3e1498f748e3f2270a662',
     armv7l: 'bf7f4e7c05d2c555c5a2c7fc99d55e2e317ac18873a3e1498f748e3f2270a662',
       i686: 'bb0e804001499f3d971bce13199e0afe89e890400573f6a414ecaa69f350737d',
     x86_64: 'e7c4c298baa8bcedf1c8165a43736d118abffad4b7b610525603ea22305141db'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zstd' => :library
end
