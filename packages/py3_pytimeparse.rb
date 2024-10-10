require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version "1.1.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '063641a7b2019493c2edb843e6ce45872f384b0ce9f1ddd35f331456308ef59a',
     armv7l: '063641a7b2019493c2edb843e6ce45872f384b0ce9f1ddd35f331456308ef59a',
       i686: 'c20de873699f47fe9a359e5de6781b29d237808a864fb9703c7a861e5c8dbbd6',
     x86_64: '0e11c412528b032bb641f0d37639e95761ae39b5b47df113447d23bffe0dd960'
  })

  depends_on 'python3' => :build

  no_source_build
end
