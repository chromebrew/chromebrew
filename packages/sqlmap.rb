require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.8.12.post1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6e4151cacaa39eda43e36f2cfbb1b43bb911c73ff70262a01b11c5c4092677c',
     armv7l: 'f6e4151cacaa39eda43e36f2cfbb1b43bb911c73ff70262a01b11c5c4092677c',
       i686: '4bd5ac422ff7c69ec854a6ec364815d299b1ad9fe87b2bec958e0101b3986e14',
     x86_64: '3b6a6d5cef96fda6974ae3b5632c29a1a3dbf81fa98ddae4237bbf375230ce43'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
