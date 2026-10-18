require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.21.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ade4572abd6eeedd9198341951a8cdf5f54b4b446e2ed3a19353e085438ee93',
     armv7l: '0ade4572abd6eeedd9198341951a8cdf5f54b4b446e2ed3a19353e085438ee93',
       i686: 'a038e0e129e8c885cc955be18e2064588dfdc0e0d5b18a30dab88248cf5429bc',
     x86_64: '1bcd5f11289bb0e2884ab7bc03c2225b7b2662bd7aac24a4ed7d2a803057306f'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
