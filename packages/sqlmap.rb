require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.7-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b1556424aae5a3277784118666bf68700334cf9d176e29f5da8d6c00828e077',
     armv7l: '1b1556424aae5a3277784118666bf68700334cf9d176e29f5da8d6c00828e077',
       i686: '5509dbd13b45902f60d86ced5f2b7170df5784c22e5b8e621ed1a7bf7dc05536',
     x86_64: '41e5175977f6ccd9f6ec85b1b222599edf4662d8364ad3e5312159873277f1d8'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
