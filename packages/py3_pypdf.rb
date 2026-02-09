require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.7.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac25c158fc7ce73be5ba560c6d5d5ef10b546a76b8436c86f294373f4e14a0f1',
     armv7l: 'ac25c158fc7ce73be5ba560c6d5d5ef10b546a76b8436c86f294373f4e14a0f1',
       i686: '3a0be2d100eb4c582054fe3764295331537015ccd5fc41d26afff5a4f5f9b223',
     x86_64: '4573d11b4d665d41e45997b120542c5856d4717d6bebe0597035c47925f446b4'
  })

  depends_on 'python3'

  no_source_build
end
