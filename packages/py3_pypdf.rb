require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.9.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9661cfa1354e33e308dfa2125118761827ab9962e3be96fc22571fbd9af60e1e',
     armv7l: '9661cfa1354e33e308dfa2125118761827ab9962e3be96fc22571fbd9af60e1e',
       i686: '0e21fc6845683a7af80ea8092fd7670561a562b1704ef3c11df2ab8a9519cc83',
     x86_64: 'c81cccaf94175c564b45feff61e350d7d8cbd5e8a412e89cc04ecfa6825e7f43'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
