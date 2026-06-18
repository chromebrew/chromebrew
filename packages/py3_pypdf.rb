require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.13.3-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb0e28ffe67a0c26a2b39554a8cdf011965c735db759d9ba60afd21ffaf8b678',
     armv7l: 'eb0e28ffe67a0c26a2b39554a8cdf011965c735db759d9ba60afd21ffaf8b678',
       i686: 'ec233ae03a4378212d80189b028cf042f8e3e6058ed577757adc7719ca505892',
     x86_64: '6730f7f4663dde8c208d19a4bcfcd4e7f0ef33c14e08c457d76206f177e543f6'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
