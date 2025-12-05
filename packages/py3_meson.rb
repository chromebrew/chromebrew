require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.9.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b629f2c9b3dd6cc4957816d20c71771069c85e2efb71226bb7a45875c8134aa6',
     armv7l: 'b629f2c9b3dd6cc4957816d20c71771069c85e2efb71226bb7a45875c8134aa6',
       i686: 'ae67c3fdf65eed3fda95f0043025d6495d1bfa174dfbd24ed113dd9a119b6572',
     x86_64: '8b16369283a45d6137bf4fff518c99f7f725ffb966ba49f6085012197259bd8c'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
