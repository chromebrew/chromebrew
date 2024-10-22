require 'buildsystems/autotools'

class Libdatrie < Autotools
  description 'An Implementation of Double-Array Trie'
  homepage 'https://linux.thai.net/~thep/datrie/datrie.html'
  version '0.2.13'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/tlwg/libdatrie/releases/download/v0.2.13/libdatrie-0.2.13.tar.xz'
  source_sha256 '12231bb2be2581a7f0fb9904092d24b0ed2a271a16835071ed97bed65267f4be'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4035b9aca7366485411309cd7a20b737bea342dd06fe65e4424fe6e8bf24ddc',
     armv7l: 'e4035b9aca7366485411309cd7a20b737bea342dd06fe65e4424fe6e8bf24ddc',
       i686: '0fe52f15c63b358ccb6d56e6556f1038ed1702bf150074989a7f58306b80e92c',
     x86_64: '5f7d3acce68bb40cd627521d8c984b160dfee049840e004fe0f2edd64b321dff'
  })

  run_tests
end
