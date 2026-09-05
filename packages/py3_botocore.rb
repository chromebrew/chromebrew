require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.89-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ceecbb77a778bf088e3e43ead4b53829050994e7965667ae2c06e67e662a7973',
     armv7l: 'ceecbb77a778bf088e3e43ead4b53829050994e7965667ae2c06e67e662a7973',
       i686: '4703978996e8e50be3a4f0d75e285585967a4e79c9d98c966a0941dfcfc4015c',
     x86_64: 'e4c81ab9994c64410615b2d037eb7957dc6a77e5e2c86884b40e19e2f2640cdb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
