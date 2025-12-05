require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.12-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '368f0791ebc559282a0bcc384bddd6d7677080d7d72f821e905cc438cf270a28',
     armv7l: '368f0791ebc559282a0bcc384bddd6d7677080d7d72f821e905cc438cf270a28',
       i686: 'fb764e573955f8170dbb2546df3551d6da0f405891dadadbec562995cb4a8e19',
     x86_64: '79c118fb4adaac94454e0da3bcd1ab9a7ff6b5d0b47551da8170151bb204cf66'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
