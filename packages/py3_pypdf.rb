require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "7.1.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f2eb91a03b99436d0c5614ea1fc1cf6f376bbb4449b71baed0b9e56d5a21998',
     armv7l: '9f2eb91a03b99436d0c5614ea1fc1cf6f376bbb4449b71baed0b9e56d5a21998',
       i686: '50bbd5d23bea7adba230b8ff7523ee014c021c29788c60f1652ab511099bcdbf',
     x86_64: '261889cf5dbecba825a421440a2c71feca1211d67556f5fb3a4ff2e02f8b88fa'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
