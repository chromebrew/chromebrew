require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.8-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd41586186a057d5a5230ab88728b595d0449e3c49371ff81e749485a5ab6c404',
     armv7l: 'd41586186a057d5a5230ab88728b595d0449e3c49371ff81e749485a5ab6c404',
       i686: '5509dbd13b45902f60d86ced5f2b7170df5784c22e5b8e621ed1a7bf7dc05536',
     x86_64: '9e72f3e36f2e8210d974395d1e8ba4f4e0ef308676bd53211574e788089bb21e'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
