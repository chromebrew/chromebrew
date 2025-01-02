require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bde12ddbbc4e43c5a2493bfc9781ad68c3a6b030de12759a776a63759f839e7',
     armv7l: '7bde12ddbbc4e43c5a2493bfc9781ad68c3a6b030de12759a776a63759f839e7',
       i686: '548c934e9c1b52a37a64d7862262a9a8dc42653909806d34d97ee181f09a8056',
     x86_64: '2adf609c4be6ec557d373793856195460342060e5ad0a964842c11917d30dfdf'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
