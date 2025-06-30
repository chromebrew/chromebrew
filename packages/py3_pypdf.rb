require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.7.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa92f9df6496589066fa65595d152a2ffe5cc83c8e1212a24af77dc98b96a565',
     armv7l: 'aa92f9df6496589066fa65595d152a2ffe5cc83c8e1212a24af77dc98b96a565',
       i686: 'c30fb59f1e8c5e70177ae98503cec92191cd3e4f4ae087f82ea69fb8f7690213',
     x86_64: 'b4be6edc886909be84b1d97ff13333136708e435c06be281a24dfd5d7852065d'
  })

  depends_on 'python3'

  no_source_build
end
