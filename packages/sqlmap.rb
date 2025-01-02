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
    aarch64: 'bd3e6c04b5316b4e150f5a53587dcf95b6d2f4c81e0277b9e6f83b2645b83902',
     armv7l: 'bd3e6c04b5316b4e150f5a53587dcf95b6d2f4c81e0277b9e6f83b2645b83902',
       i686: '548c934e9c1b52a37a64d7862262a9a8dc42653909806d34d97ee181f09a8056',
     x86_64: '2adf609c4be6ec557d373793856195460342060e5ad0a964842c11917d30dfdf'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
