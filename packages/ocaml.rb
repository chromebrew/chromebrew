require 'buildsystems/autotools'

class Ocaml < Autotools
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'https://ocaml.org/'
  version '5.5.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e70396d86885b0fa1c8b4b4200ce64dc10eb527eb5c96b9b01dc9cbcab873597',
     armv7l: 'e70396d86885b0fa1c8b4b4200ce64dc10eb527eb5c96b9b01dc9cbcab873597',
       i686: '249dd407eadc644cf7ff268782302a83356accc884fc6f2351ed06fed5d17d39',
     x86_64: '1c1f585eec354d509199e1c5065fb71261fd04c9704efc2b93e7307b5c61277c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zstd' => :library
end
