require 'buildsystems/autotools'

class Libthai < Autotools
  description 'LibThai is a set of Thai language support routines.'
  homepage 'https://linux.thai.net/projects/libthai/'
  version '0.1.29'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/tlwg/libthai/releases/download/v0.1.29/libthai-0.1.29.tar.xz'
  source_sha256 'fc80cc7dcb50e11302b417cebd24f2d30a8b987292e77e003267b9100d0f4bcd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71504351a03d401107e87f373e092abe9f88f7fa737243ef10815e35a5f38799',
     armv7l: '71504351a03d401107e87f373e092abe9f88f7fa737243ef10815e35a5f38799',
       i686: '27aba7e03c87d89eb79709b7eb51963c4489b309ac6b5036fa7c7e742fc80d53',
     x86_64: 'b07394ebe99f6ac34a95275f574c36587576ef586c2d7923a77b31ba3c023ecc'
  })

  depends_on 'libdatrie'

  run_tests
end
