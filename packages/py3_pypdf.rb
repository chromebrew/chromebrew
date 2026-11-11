require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "7.0.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7b99a2ff6737070f01b8b73109424179581dd06154819ff2776737fa5fae26f',
     armv7l: 'a7b99a2ff6737070f01b8b73109424179581dd06154819ff2776737fa5fae26f',
       i686: 'e4899e5782404e4ecba2993028098a843476b2020d15b7dbfe7678555adcf867',
     x86_64: 'd9b4e83e75778e126c01392784164690e5e6cac34309e26ff95d0d02b0f51293'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
