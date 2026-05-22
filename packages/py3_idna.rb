require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.16-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a2b75a6235ba02b7d94b693e352310fe5a7b51322d75b7fac6c8703f2ae6e76',
     armv7l: '0a2b75a6235ba02b7d94b693e352310fe5a7b51322d75b7fac6c8703f2ae6e76',
       i686: '6f0235ea7fab7b527432926c1411a01c3d21eac874007e2cadea89c341c7432a',
     x86_64: 'b8abb66c5c50d285f9872c5475ebd39901c0fd337a4658599453be5077e8c24d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
