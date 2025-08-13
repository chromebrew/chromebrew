require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.0.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7fb54cd6cc2798b880d9337ff9df88eaab15bc7081b9249ed188025180aad1e8',
     armv7l: '7fb54cd6cc2798b880d9337ff9df88eaab15bc7081b9249ed188025180aad1e8',
       i686: '29120967490e5c6e832275c06f5452003ba9da8251bdb17abc81dccea5ca3e1e',
     x86_64: 'cc87a505f44e2104e522c4a0078521241f2f2f5d1e84306e8389b6d59d4574b3'
  })

  depends_on 'python3'

  no_source_build
end
