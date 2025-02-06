require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.2-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd3e6c04b5316b4e150f5a53587dcf95b6d2f4c81e0277b9e6f83b2645b83902',
     armv7l: 'bd3e6c04b5316b4e150f5a53587dcf95b6d2f4c81e0277b9e6f83b2645b83902',
       i686: '007aae2dab735a9639580c5c9e3e1d7c049c7690b3ea5e3461f2cdab453138fc',
     x86_64: 'f4a678be619e5b59fc4aaa75bb6b423357dc65af6a878abc344b801fe1d0946e'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
