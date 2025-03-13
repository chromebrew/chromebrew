require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.3-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e324d9c57b209be96ebf969ad3a5058251fa2d7c28370812e1708d5d1f49a06f',
     armv7l: 'e324d9c57b209be96ebf969ad3a5058251fa2d7c28370812e1708d5d1f49a06f',
       i686: 'fe6c727ab6d80a83d0ea2103e19e798e738006ab0b2399e04fc41b8b78b4748c',
     x86_64: 'f69a5ec5993ede83bfafa138f11ccbc7c394ca3660bc155001aa27c7373169b4'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
