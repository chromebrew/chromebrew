require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.18.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dad6e9f869d3d9107807e98777ac6c8ea07536b49bc0b8329ef99e95d2db7f22',
     armv7l: 'dad6e9f869d3d9107807e98777ac6c8ea07536b49bc0b8329ef99e95d2db7f22',
       i686: '2e309021d8b108d0b30dd7588101ca4097905e2ad3baa4c4f1ee6a2f8662f806',
     x86_64: '560fa5866b2337fa4581d2d5db0853f0a95f1a13b82ebda2397504c90d6b3c92'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
