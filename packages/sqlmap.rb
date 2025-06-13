require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.6-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '951edcf2365f11e2c55c2e109a72d1ebcf34d8ce6b29356b1fa563bcc5e0c364',
     armv7l: '951edcf2365f11e2c55c2e109a72d1ebcf34d8ce6b29356b1fa563bcc5e0c364',
       i686: '937fbf4d095e7fbc6b4c7996ead1da20c06529ca9d63be2d091fddc3f593062d',
     x86_64: '41e5175977f6ccd9f6ec85b1b222599edf4662d8364ad3e5312159873277f1d8'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
