require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.3-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8c79d79b4e39bbb8c5481136bee59b1a7b6fab788b82755fee70d568fd6c8b1',
     armv7l: 'a8c79d79b4e39bbb8c5481136bee59b1a7b6fab788b82755fee70d568fd6c8b1',
       i686: '8aa1878aeb96310074df896c3b7a4d69c64717dbd1cae8ab4bb71cbfdc76024a',
     x86_64: '3e6ded268ce120bc422b3f229536d40fd7a27e263af02b710f3bd30a50864080'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
